require "subtle/dominikh/graph"

class CPU
  attr_reader :number

  def initialize(number)
    @number     = number
    @last_check = 0
    @last_sum   = 0
    load # to have a sane start value
  end

  # @return [Fixnum] The current CPU load, as a percentage
  def load
    File.read("/proc/stat").scan(/cpu#{@number} (\d+) (\d+) (\d+)/) do |user, nice, system|
      delta      = Time.now.to_i - @last_check
      delta = 1 if delta < 1

      @last_check       = Time.now.to_i

      sum         = user.to_i + nice.to_i + system.to_i
      use         = ((sum - @last_sum) / delta / 100.0)

      @last_sum        = sum

      load = (use * 100.0).ceil
      load = 100 if load > 100

      return load
    end
  end

  # @return [Array<CPU>] An array of all {CPU CPUs}
  def self.all
    cpus = []
    File.read("/proc/stat").scan(/cpu(\d+)/) do |number|
      cpus << CPU.new(number.first.to_i)
    end
    cpus
  end
end


configure :cpuchart do |s|
  s.interval = 1
  s.cpus = CPU.all

  if (s.config||{})[:combine]
    s.graph = Dominikh::Chart.new(25, s.geometry.height)
    graph.extend(Dominikh::ColoredGraph)
  else
    s.graphs = Array.new(s.cpus.size) {
      graph = Dominikh::Chart.new(25, s.geometry.height)
      graph.extend(Dominikh::ColoredGraph)
      graph
    }
  end
end

on :run do |s|
  if (s.config||{})[:combine]
    val = s.cpus.map(&:load).inject(:+) / s.cpus.size.to_f
    s.graph.push(val)
    s.data = s.graph.to_s
  else
    loads = s.cpus.map(&:load)
    s.graphs.zip(loads) {|graph, load| graph.push(load)}
    s.data = s.graphs.map(&:to_s).join
  end
end
