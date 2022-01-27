require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Testing validations on a single subject' do
    subject { User.new(name: 'mustafa abbas', photo: 'photo', bio: 'bio', posts_counter: 5) }
    before { subject.save }

    it 'is valid with the inserted valid attributes' do
      expect(subject).to be_valid
    end

    it 'name must not be blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter must be an integer greater than or equal to zero' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end
end
