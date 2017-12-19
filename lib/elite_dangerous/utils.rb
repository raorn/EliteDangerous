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

    def filter_dist(src, tgt, max_dist)
      src.where(Sequel.lit('|/((x-(?))^2+(y-(?))^2+(z-(?))^2) < ?', tgt.x, tgt.y, tgt.z, max_dist))
    end

    def filter(src, key, val)
      src.where(key => val)
    end
  end
end
