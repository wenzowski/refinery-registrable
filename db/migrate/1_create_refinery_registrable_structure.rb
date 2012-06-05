class CreateRefineryRegistrableStructure < ActiveRecord::Migration
  def change

    create_table Refinery::Registrable::UserField.table_name do |t|
      t.string      :name,        :null => false
      t.string      :type,        :null => false
      t.timestamps
    end
    add_index Refinery::Registrable::UserField.table_name, :id


    create_table Refinery::Registrable::UserFieldValidation.table_name do |t|
      t.references  :user_field,  :null => false
      t.string      :value,       :null => false
      t.string      :type,        :null => false
      t.timestamps
    end
    add_index Refinery::Registrable::UserFieldValidation.table_name, :id
    add_index Refinery::Registrable::UserFieldValidation.table_name, :user_field_id,
      :name => 'index_refinery_registrable_user_field_validations_on_field_id'
    add_index Refinery::Registrable::UserFieldValidation.table_name, :type


    create_table Refinery::Registrable::UserFieldAttribute.table_name do |t|
      t.references  :user,        :null => false
      t.references  :user_field,  :null => false
      t.string      :value,       :null => false
      t.string      :type,        :null => false
      t.timestamps
    end
    add_index Refinery::Registrable::UserFieldAttribute.table_name, :id
    add_index Refinery::Registrable::UserFieldAttribute.table_name, :user_id
    add_index Refinery::Registrable::UserFieldAttribute.table_name, :user_field_id,
      :name => 'index_refinery_registrable_user_field_attributes_on_field_id'
    add_index Refinery::Registrable::UserFieldAttribute.table_name, :type

  end
end
