class AddForeignKeyToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :answers, :users
  end
end
