require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'mustafa abbas', photo: 'photo', bio: 'bio', posts_counter: 5)
  user.save

  context 'Testing validations on a single subject' do
    subject { Post.new(title: 'Post 1', text: '1', user_id: user.id, comments_counter: 0, likes_counter: 0) }

    it 'is valid with the inserted valid attributes' do
      expect(subject).to be_valid
    end

    it 'title must not be blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title must not exceed 250 characters' do
      subject.title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
       Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
       when an unknown printer took a galley of type and scrambled it to make a type specimen book.
        It has survived not only five centuries, but also the leap into electronic typesetting,
      remaining essentially unchanged. It was popularised in the 1960s with the release of
      Letraset sheets containing Lorem Ipsum passages,
       and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
      "
      expect(subject).to_not be_valid
    end

    it 'comments_counter must be an integer greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes_counter must be an integer greater than or equal to zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end
end
