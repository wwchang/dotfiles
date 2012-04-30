#!/usr/bin/python

#Wikipedia allows you to create a watchlist of articles that you want to monitor
#and notifies you when any of those articles is modified. This Python script uses
#the MediaWiki API [http://meta.wikimedia.org/wiki/API] to fetch your watchlist
#as an RSS/ATOM feed. 

#Usage: 
    #wikiwatch.py wikipedia username wikipedia password [atom/rss] 

    #Example: 
    #wikiwatch.py myuserid mypass atom 

"""Get Wikipedia watchlist as an RSS/ATOM feed

(c) Jyotirmoy Bhattacharya, 2007
Licensed under GNU GPL v. 2

Usage: wikiwatch <username> <password> [format]
[format] is either 'rss' or 'atom'
"""

import sys
import xml.sax,xml.sax.handler
import urllib,urllib2,cookielib,httplib

#Constants
version="0.2alpha"
user_agent="wikiwatch.py (jmoy.matecon@gmail.com)/"+version
usage="Usage: wikiwatch <Username> <Password> [rss/atom]"
apiURL="http://en.wikipedia.org/w/api.php"



class LoginFailedException(Exception):
    """Login to Wikipedia failed
    """
    def __init__(self,status):
        self.message=status



class RunTimeError(Exception):
    """Run-time error
    """
    def __init__(self,what):
        self.message=what



class BadCmdException(Exception):
    """Bad command-line arguments to program
    """
    def __init__(self):
        self.message="Bad command-line argument"
        


def callapi(data,cookie_jar):
    """Make an API call
    data: list of tuples containing data to be sent in the PUT request
    cookie_jar: cookielib.CookieJar used for the request

    Returns a file-like object containing the response
    """

    opener=urllib2.build_opener(urllib2.HTTPCookieProcessor(cookie_jar))
    req=urllib2.Request(apiURL,urllib.urlencode(data))
    req.add_header("User-Agent",user_agent)
    return opener.open(req)

        


def wikiauth(uname,passwd,cookie_jar):
    """Authenticate to Wikipedia and return authentication tokens as cookies

    uname: Wikipedia username
    passwd: Wikipedia password
    cookie_jar: cookielib.CookieJar to store authentication cookies

    Returns nothing
    Raises LoginFailedException in case of failure
    """
    
    class LoginResp(xml.sax.ContentHandler):
        def __init__(self):
            self.result=""

        def startElement(self,name,attrs):
            if name=="login":
                self.result=attrs["result"]
    try:
        #Create SAX parser
        parser=xml.sax.make_parser()
        parser.setFeature(xml.sax.handler.feature_namespaces,0)
        lr=LoginResp()
        parser.setContentHandler(lr)

        #Get login response
        r=callapi([("action","login"),
                   ("format","xml"),
                   ("lgname",uname),
                   ("lgpassword",passwd)],
                  cookie_jar)
        #Parse login response to get tokens and see if login succeeded
        parser.parse(r)
        if lr.result!="Success":
            raise LoginFailedException("Authentication denied: "+lr.result)
        pass
    except xml.sax.SAXException,inst:
        raise LoginFailedException("Parse error in login response: "
                                   +inst.getMessage())

        
    


def getfeed(uname,passwd,feedformat):
    """Get Wikipedia watchlist feed

    uname: Wikipedia username
    passwd: Wikipedia password
    feedformat: format of the feed, must be 'rss' or 'atom'

    Returns a file-like object containing the feed
    """

    jar=cookielib.CookieJar()
    wikiauth(uname,passwd,jar)
    return callapi([("action","feedwatchlist"),
                    ("feedformat",feedformat)],
                   jar)




def do_fetch(argv):
    """Parse command-line arguments and fetch feed

    argv: list of command-line arguments

    Returns feed as a string
    Raises BadCmdException if arguments are not proper
    """

    format="atom"
    if len(argv)==3:
        pass
    elif len(argv)==4:
        if (argv[3]=="rss" or argv[3]=="atom"):
            format=argv[3]
        else:
            raise BadCmdException()
    else:
        raise BadCmdException()

    try:
        r=getfeed(argv[1],argv[2],format)
        return r.read()
    except httplib.HTTPException,inst:
        raise RunTimeError("httplib Exception: "+str(inst))
    except urllib2.URLError, inst:
        raise RunTimeError("urllib Exception: "+str(inst.reason))




#Main program
if __name__=="__main__":
    try:
        print do_fetch(sys.argv)
    except BadCmdException:
        sys.stderr.write("%s\n"%usage)
        sys.exit(1)
    except LoginFailedException,inst:
        sys.stderr.write("Login failed: %s\n"%inst.message)
        sys.exit(2)
    except RunTimeError, inst:
        sys.stderr.write("Runtime error: %s\n"%inst.message)
        sys.exit(2)

