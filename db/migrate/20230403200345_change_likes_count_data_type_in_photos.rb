class ChangeLikesCountDataTypeInPhotos < ActiveRecord::Migration[6.0]
  def change
    change_column :photos, :likes_count, :integer
  end
end
