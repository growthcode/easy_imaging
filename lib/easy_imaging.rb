require "easy_imaging/version"
require "mini_magick"

module EasyImaging
  def rotate(*args)
    method_called = __method__
    all_style_keys.each do |style|
      self.process(style, method_called, *args)
    end
  end

  def style_original
    :original
  end

  # returns an array of model's paperclip keys, excluding the :original'
  def style_keys
    self.style.keys
  end

  def all_style_keys
    self.paperclip_image.styles.keys + [style_original]
  end

  def process(style, method_called, *args)
    path = self.paperclip_image.path(style)
    source = MiniMagick::Image.open(path)
    source = source.send(method_called, *args)
    source.write(path)
  end
end

