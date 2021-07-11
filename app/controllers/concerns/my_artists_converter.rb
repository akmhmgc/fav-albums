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
      return false
    end

    # 名前が10文字以内かどうか
    unless images_list.length == 5
      @error = "アーティストの数が正しくありません。"
      return false
    end

    @image = MiniMagick::Image.open("app/assets/images/bg.jpg")
    @image_width = (@image.width - BORDER_WIDTH * 8) / 5
    add_name_title(name)
    add_artists(images_list)
  end

  def add_name_title(name)
    @image.combine_options do |config|
      Rails.logger.info("text #{NAME_POSITION} '#{name}さんを'")
      Rails.logger.info("text #{NAME_POSITION} '#{name.force_encoding('UTF-8')}さんを'")

      Rails.logger.info(NAME_FONT.encoding)
      Rails.logger.info(GRAVITY.encoding)

      # nickname
      config.font NAME_FONT
      config.gravity GRAVITY
      config.pointsize NAME_FONT_SIZE
      sentence1 = "#{name}さんを"
      config.draw "text #{NAME_POSITION} #{sentence1}"

      # title
      # config.font TITLE_FONT
      # config.pointsize TITLE_FONT_SIZE
      # config.draw "text #{TITLE_POSITION} 構成する５組のアーティスト"
    end
  end

  def add_artists(images_list)
    images_list.each_with_index do |image_url, index|
      # 追加する画像の整形
      image = MiniMagick::Image.open(image_url)
      image.resize "#{@image_width}x"
      image.crop "#{@image_width}x#{@image_width}+0+0"

      @image = @image.composite(image) do |c|
        c.compose "Over"
        c.geometry "+#{BORDER_WIDTH * 2 + index * (@image_width + BORDER_WIDTH)}+#{IMAGE_Y_POSITION}"
      end
    end
  end
end
