class Array

        def empty_filter?
          self.uniq.length == 1 and self[0] == ""
        end

        def uniq_numerics
          out = []
          self.uniq.each { |x|
		out << x if x != ""
          }
          out
        end

        def sum
          inject( nil ) { |sum,x| sum ? sum+x : x }
        end

        def mean
          sum.to_f / size
        end

end


class Float
  def round_to(x)
    return "na" if self.infinite? || self.nan? || self.nil? || self == 0
    (self * 10**x).round.to_f / 10**x
  end

  def perc_round_to(x)
    return "na" if self.infinite? || self.nan? || self.nil? || self == 0
    (((self * 10**x).round.to_f / 10**x) * 10).to_s + "%" 
  end

  def ceil_to(x)
    return "na" if self.infinite? || self.nan? || self.nil? || self == 0
    (self * 10**x).ceil.to_f / 10**x
  end

  def floor_to(x)
    return "na" if self.infinite? || self.nan? || self.nil? || self == 0
    (self * 10**x).floor.to_f / 10**x
  end
end


class Junk

  def id
    -1
  end

  def method_missing(meth,*args)
    (meth.to_s =~ /_id$/).nil? ? self : -1
  end

end

