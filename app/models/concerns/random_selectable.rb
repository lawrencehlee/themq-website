module RandomSelectable
	extend ActiveSupport::Concern

	module ClassMethods
		def random(collection)
			collection.offset(rand(collection.count)).first
		end
	end
end
