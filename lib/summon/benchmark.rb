
require 'benchmark'

module Summon
  class Benchmark
    def initialize
      @timings = []
    end
    def report(name, &block)
      result = nil
      @timings << ::Benchmark.measure(name) do
        result = block.call
      end
      result
    end
    
    def output(to = $stdout)
      to.printf("%20s  %s\n", "","real time")
      to.puts(@timings.map {|t| t.format("%-20n: %r")})
    end
  end
end