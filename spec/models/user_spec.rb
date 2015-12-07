require "spec_helper"

describe CgtraderLevels::User do
  describe 'new user' do
    let!(:level) { CgtraderLevels::Level.create(experience: 0, title: 'First level') }
    let!(:user) { CgtraderLevels::User.new }
    
    it 'has 0 reputation points' do
      expect(user.reputation).to eq(0)
    end

    it "has assigned 'First level'" do
      expect(user.level).to eq(level)
    end
  end

  describe 'level up' do
    let!(:level_1) { CgtraderLevels::Level.create(experience: 0, title: 'First level') }
    let!(:level_2) { CgtraderLevels::Level.create(experience: 10, title: 'Second level') }
    let!(:level_3) { CgtraderLevels::Level.create(experience: 13, title: 'Third level') }
    let!(:user) { CgtraderLevels::User.create }

    it "level ups from 'First level' to 'Second level'" do
      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.reload.level }.from(level_1).to(level_2)
    end

    it "level ups from 'First level' to 'Third level'" do
      expect {
        user.update_attribute(:reputation, 13)
      }.to change { user.reload.level }.from(level_1).to(level_3)
    end
  end

  describe 'level up bonuses & privileges' do
    let!(:user) { CgtraderLevels::User.create }
    it 'gives 7 coins to user' do
      pending

      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.reload.coins }.from(1).to(8)
    end

    it 'reduces tax rate by 1'
  end
end
