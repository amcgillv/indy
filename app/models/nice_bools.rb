# ignore this file. it's in `app/models` just so rails includes it. it's helpful

class FalseClass
    def to_i
        0 
    end
end

class TrueClass
    def to_i
        1 
    end
end
