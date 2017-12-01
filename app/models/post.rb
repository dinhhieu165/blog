class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :title, presence:true

  def Post.tagged_with(name)
    tag = Tag.find_by_name(name) ? tag.posts : Post.none
  end

  def total_like
    likes.count
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    tags_name = names.split(",").map! &:strip

    exist_tags = Tag.where("name IN (?)", tags_name)

    not_exist_tags = []

    tags_name.each do |name|
      # Tag.where(name: n.strip).first_or_create!
      tag = exist_tags.detect{|tag| tag.name == name}

      next if tag

      # Build insert query
      not_exist_tags << Tag.new(name: name)
    end

    Tag.import not_exist_tags, validate: false
  end

  scope :search, ->(search){
    where("title LIKE ?","%#{search}%")
  }
end
