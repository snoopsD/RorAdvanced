class AddForeignKeyToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :questions, :users
  end
end
