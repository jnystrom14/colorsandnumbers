class DailyNumerology < ApplicationRecord
  # Automatically compute for today's date on create
  before_validation -> { compute_numerology(Date.today) }, on: :create

  validates :birth_date, presence: true

  # Compute numerology based on a target_date (defaults to Date.today)
  def compute_numerology(target_date = Date.today)
    today       = target_date
    birth_month = birth_date.month
    birth_day   = birth_date.day

    # Universal Year
    uni_year = reduce_to_master_or_single(today.year)

    # Personal Year
    personal_year = reduce_to_master_or_single(birth_month + birth_day + uni_year)

    # Personal Month
    personal_month = reduce_to_master_or_single(personal_year + today.month)

    # Personal Day
    personal_day = reduce_to_master_or_single(personal_month + today.day)
    self.number  = personal_day

    # Lookup tables
    color_map =   {1=>'Red',2=>'Orange',3=>'Yellow',4=>'Green',5=>'Blue',6=>'Indigo',7=>'Violet',8=>'Pink',9=>'Gold',11=>'Silver',22=>'Platinum'}
    gem_map   =   {1=>'Diamond',2=>'Ruby',3=>'Sapphire',4=>'Emerald',5=>'Amethyst',6=>'Topaz',7=>'Opal',8=>'Jade',9=>'Turquoise',11=>'Moonstone',22=>'Quartz'}
    affirmations = {
      1=>'I BREAK NEW GROUND AND BEGIN NEW VENTURES!',
      2=>'I TRUST THE PROGRESS OF LIFE UNFOLD IN DIVINE RIGHT ORDER!',
      3=>'I LOVE LIFE AND THE JOY OF LIVING!',
      4=>'I TURN EVERYTHING INTO AN OPPORTUNITY!',
      5=>'I WELCOME CHANGE AND EXPAND MY BOUNDARIES!',
      6=>'I ACCEPT MY RESPONSIBILITIES WITH LOVE AND JOY!',
      7=>'I ENJOY THE INNER QUEST AND FIND MANY ANSWERS!',
      8=>'I AM THE PROSPEROUS, SUCCESSFUL EXECUTIVE OF MY WORLD!',
      9=>'I AM SATISFIED, FULFILLED, AND COMPLETE!',
      11=>'I LISTEN TO THE INNER VOICE OF WISDOM!',
      22=>'I WORK FOR THE GOOD OF THE PLANET, AND I AM BLESSED!'
    }
    words = {1=>'Leadership',2=>'Harmony',3=>'Creativity',4=>'Stability',5=>'Freedom',6=>'Responsibility',7=>'Wisdom',8=>'Success',9=>'Enlightenment',11=>'Inner Vision',22=>'Global Impact'}

    self.color       = color_map[personal_day]
    self.gem         = gem_map[personal_day]
    self.affirmation = affirmations[personal_day]
    self.word        = words[personal_day]
  end

  private

  # Preserves master numbers 11 and 22, otherwise reduces to single digit
  def reduce_to_master_or_single(n)
    return n if [11, 22].include?(n)
    sum = n.to_s.chars.map(&:to_i).sum
    sum = sum.to_s.chars.map(&:to_i).sum while sum > 9
    sum
  end
end
