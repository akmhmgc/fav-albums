require 'mini_magick'
require 'securerandom'

module MyArtistsConverter
  extend ActiveSupport::Concern

  BASE_IMAGE_PATH = './app/assets/images/bg_image.png'.freeze
  GRAVITY = 'northwest'.freeze
  NAME_POSITION = '50,100'.freeze
  TITLE_POSITION = '50,150'.freeze
  NAME_FONT = './app/assets/fonts/GenShinGothic-Medium.ttf'.freeze
  TITLE_FONT = './app/assets/fonts/GenShinGothic-Medium.ttf'.freeze
  NAME_FONT_SIZE = 45
  TITLE_FONT_SIZE = 90
  IMAGE_Y_POSITION = 350
  BORDER_WIDTH = 32

  private

  def can_save_image_from_mylist?(name, images_list)
    # 名前が10文字以内かどうか
    unless name && name.length >= 1 && name.length <= 10
      @error = "ニックネームの文字数が正しくありません。"
      false
    end

    # アーティストの数が5名がどうか
    unless images_list.length == 5
      @error = "アーティストの数が正しくありません。"
      false
    end
    true
  end

  def rendered_image(name, images_list)
    image = MiniMagick::Image.open("app/assets/images/bg.jpg")
    image = add_name_title(name, image)
    add_artists(images_list, image)
  end

  def add_name_title(name, image)
    image.combine_options do |config|
      # nickname
      config.font NAME_FONT
      config.gravity GRAVITY
      config.pointsize NAME_FONT_SIZE
      sentence1 = name + "さんを".force_encoding('UTF-8')
      config.draw "text #{NAME_POSITION} '#{sentence1}'"

      # title
      config.font TITLE_FONT
      config.pointsize TITLE_FONT_SIZE
      sentence2 = "構成する５組のアーティスト".force_encoding('UTF-8')
      config.draw "text #{TITLE_POSITION} '#{sentence2}'"
    end
    image
  end

  def add_artists(url_list, image)
    image_width = (image.width - BORDER_WIDTH * 8) / 5
    url_list.each_with_index do |image_url, index|
      # 追加する画像の整形
      artist_image = MiniMagick::Image.open(image_url)
      artist_image.resize "#{image_width}x"
      artist_image.crop "#{image_width}x#{image_width}+0+0"

      image = image.composite(artist_image) do |c|
        c.compose "Over"
        c.geometry "+#{BORDER_WIDTH * 2 + index * (image_width + BORDER_WIDTH)}+#{IMAGE_Y_POSITION}"
      end
    end
    image
  end
end
