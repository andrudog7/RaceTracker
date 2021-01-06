module UsersHelper
    def marathons
        self.types.where(:name => "Marathon").first.races
    end
end
