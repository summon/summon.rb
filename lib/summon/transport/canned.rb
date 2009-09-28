module Summon
  module Transport    
    class Canned
      def get(*args)
        JSON.parse(File.read(File.dirname(__FILE__) + '/canned.json'))
      end
    end    
  end
end