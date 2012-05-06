#!/usr/bin/env python

# http://code.bulix.org
# need : python-beautifulsoup

from __future__ import with_statement

from BeautifulSoup import BeautifulSoup
import logging
import urllib
import sys

__author__ = 'Maxime Petazzoni <maxime.petazzoni@bulix.org>'
__version__ = '1.0'

l = logging.getLogger('paster')

LANGS = ['plain', 'bash', 'c', 'cpp', 'csharp', 'java', 'javascript',
         'css', 'lua', 'perl', 'php', 'python', 'ruby', 'sql', 'vb', 'xml']
SERVER = 'http://code.bulix.org'

class BasePasteException:
    """Base class for Paster errors."""

    def getMessage(self):
        return self.__doc__

class ServerUnreacheable(BasePasteException):
    """Unable to reach the paste server!"""

class APIVersionMismatch(BasePasteException):
    """The remote API version is not supported"""

    def __init__(self, got, excepted):
        self.got = got
        self.excepted = excepted

    def getMessage(self):
        return '%s (got %s while expecting %s).' % (self.__doc__,
                self.got, self.excepted)

class ChallengeError(BasePasteException):
    """Unable to proceed with the antispam challenge!"""

class FileInputError(BasePasteException):
    """Unable to read the given input file!"""

class PasteError(BasePasteException):
    """Paste was refused by server!"""

class Paster:
    def __init__(self, options):
        self.options = options
        self.antispam = {}

        l.debug('Sending %s paste to %s...' % (options.lang, options.server))

    def paste(self, filename):
        """Paste a file using this paster's options."""

        self.challenge()

        params = self.antispam
        params.update({'__antispam_result': sum(self.antispam.values()),
                       '__lang': self.options.lang,
                       '__contents': self.read_file(filename),
                       '__title': self.options.title,
                       '__submit': 'Paste'})

        if self.options.private:
            params['__private'] = 'on'
        if self.options.wrap:
            params['__wrap'] = 'on'

        try:
            page = urllib.urlopen(self.options.server,
                                  urllib.urlencode(params))
            if page.geturl() == self.options.server:
                raise PasteError
        except IOError:
            raise ServerUnreacheable

        return page.geturl()

    def read_file(self, filename):
        try:
            if filename == '-':
                l.debug('Reading contents from stdin...')
                data = sys.stdin.read()
            else:
                l.debug('Reading contents from `%s`...' % filename)
                with open(filename) as f:
                    data = f.read()
        except IOError, e:
            raise FileInputError

        return data

    def challenge(self):
        """Check the API version and get the antispam challenge
        parameters."""

        l.debug('Getting antispam challenge at %s...' % self.options.server)
        try:
            page = urllib.urlopen(self.options.server).read()
        except IOError:
            raise ServerUnreacheable

        soup = BeautifulSoup(page)
        tags = soup.findAll(name='input', attrs={'type': 'hidden'})

        for tag in tags:
            if (tag['name'] == '__api_version' and
                tag['value'] != __version__):
                raise APIVersionMismatch, (tag['value'], __version__)
            if tag['name'].startswith('__antispam_rand'):
                self.antispam[tag['name']] = int(tag['value'])

        if not (self.antispam.has_key('__antispam_rand1') and
                self.antispam.has_key('__antispam_rand2')):
            raise ChallengeError

        challenge = map(str, self.antispam.values())
        l.debug('API version %s. Got antispam challenge: %s.' %
                (__version__, '+'.join(challenge)))


def main():
    import optparse

    usage = "Usage: %prog [options] [file]"
    parser = optparse.OptionParser(usage=usage)
    parser.add_option('-l', '--lang', choices=LANGS,
                      help=('Set the paste programming language to LANG. '
                            'Choose from: %s.' % ', '.join(LANGS)),
                      default='plain')
    parser.add_option('-t', '--title', help='Set a title for this paste',
                      default='')

    misc = optparse.OptionGroup(parser, 'Miscelaneous settings')
    misc.add_option('-p', '--private', action='store_true',
                    default=False, help='Mark the paste as private')
    misc.add_option('-w', '--wrap', action='store_true',
                    default=False, help='Wrap long lines')
    misc.add_option('-s', '--server', default=SERVER,
                    help='Send the paste to HOST', metavar='HOST')
    parser.add_option_group(misc)

    log = optparse.OptionGroup(parser, 'Logging options')
    log.add_option('-v', '--verbose', action='store_const',
                   dest='loglevel', help='Output debugging messages',
                   const=logging.DEBUG, default=logging.WARN)
    parser.add_option_group(log)

    (options, args) = parser.parse_args()

    logging.basicConfig(stream=sys.stdout, level=options.loglevel,
                        format='%(levelname)s(%(name)s): %(message)s')

    if not len(args):
        file = '-'
    else:
        file = args[0]

    try:
        url = Paster(options).paste(file)
        l.info(url)
        print url
    except BasePasteException, e:
        l.error(e.getMessage())
        return 1

    return 0

if __name__ == '__main__':
    sys.exit(main())
