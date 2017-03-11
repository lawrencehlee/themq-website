class ChangeBinaryToBoolean < ActiveRecord::Migration
  def change
    change_column :articles, :brief, :boolean
    change_column_null :articles, :brief, false
    change_column_default :articles, :brief, 0

    change_column :features, :spread, :boolean
    change_column_null :features, :spread, false
    change_column_default :features, :spread, 0

    change_column :ed_pcps, :ed, :boolean
    change_column :ed_pcps, :point, :boolean
    change_column :ed_pcps, :counterpoint, :boolean

    change_column :issues, :current, :boolean
    change_column_default :issues, :current, 0

    change_column :people, :current, :boolean
    change_column_default :people, :current, 0
  end
end
