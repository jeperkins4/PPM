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

