require 'rails_helper'

def armstrong?(x_value)
  x_str = x_value.to_s
  x_value == x_str.chars.sum { |digit| digit.to_i**x_str.size }
end

def armstrong_nums(iter_val)
  if iter_val == 1
    (10**(iter_val - 1)...10**iter_val).filter { |x_value| armstrong?(x_value) }
  else
    (10**(iter_val - 1)...10**iter_val).filter { |x_value| armstrong?(x_value) }.concat armstrong_nums(iter_val - 1)
  end
end

def fetch_nums(number)
  visit root_path
  fill_in 'number', with: number
  click_button 'commit'
  find(:id, 'results').text
end

describe 'Armstrong Calculator', type: :feature do
  it 'doesn\'t allow to submit a string', js: true do
    visit root_path
    fill_in 'number', with: 'number'
    # expect(2).to eq(1)
    expect(find_field('number').value).not_to eq 'string'
  end

  it 'outputs a fair table for 2', js: true do
    results = (1..2).each do |iter|
      expect(fetch_nums(iter)).to match(armstrong_nums(iter))
    end
  end
end
