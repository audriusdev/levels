class CgtraderLevels::User < ActiveRecord::Base
  attr_reader :level

  after_update :set_new_level
  after_update :reward_user, if: :level_id_changed?

  after_initialize do
    self.reputation = 0

    set_new_level
  end

  private

  def set_new_level
    matching_level = CgtraderLevels::Level.where(experience: reputation).first

    if matching_level
      self.level_id = matching_level.id
      @level = matching_level
    end
  end

  def reward_user
    if reputation > reputation_was
      add_coins
      reduce_taxes
    end
  end

  def add_coins
    self.coins += 7
  end

  def reduce_taxes
    self.tax -= 1 
  end
end
