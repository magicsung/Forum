class AddPaperclipToPosts < ActiveRecord::Migration
  
  def change
    add_attachment :posts, :upload_file
  end
  
end
