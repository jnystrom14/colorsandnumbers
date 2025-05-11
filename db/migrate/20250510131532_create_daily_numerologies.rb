class CreateDailyNumerologies < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_numerologies do |t|
      t.date :birth_date
      t.string :color
      t.integer :number
      t.string :gem
      t.text :affirmation
      t.string :word

      t.timestamps
    end
  end
end
