class EdPcp < ActiveRecord::Base
    def get_ed_pcp_text
 	        filepath = File.join(
		        Rails.root, 'app', 'assets', 'articles', self.text)
        File.read(filepath).encode("UTF-8", :invalid=>:replace)       
    end
end
