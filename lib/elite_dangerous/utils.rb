require 'json'

module EliteDangerous
  module Utils
    def each_json(fname)
      File.open(fname) do |fd|
        fd.each_line do |ln|
          yield JSON.parse(ln)
        end
      end
    end

    def dist(s, t)
      Math.sqrt((s.x-t.x)**2+(s.y-t.y)**2+(s.z-t.z)**2).round(2)
    end
  end
end
