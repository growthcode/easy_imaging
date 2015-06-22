require "easy_imaging/version"
require "mini_magick"

module EasyImaging
  AVAILABLE_METHODS = ["adaptive-blur",  "adaptive-resize",  "adaptive-sharpen",  "adjoin",  "affine",  "alpha",  "annotate",  "antialias",  "append",  "authenticate",  "auto-gamma",  "auto-level",  "auto-orient",  "background",  "bench",  "bias",  "black-threshold",  "blue-primary",  "blue-shift",  "blur",  "border",  "bordercolor",  "brightness-contrast",  "canny",  "caption",  "cdl",  "channel",  "charcoal",  "chop",  "clip",  "clamp",  "clip-mask",  "clip-path",  "clut",  "complexoperator",  "connected-components",  "contrast-stretch",  "coalesce",  "colorize",  "color-matrix",  "colors",  "colorspace",  "combine",  "comment",  "compose",  "composite",  "compress",  "contrast",  "convolve",  "crop",  "cycle",  "decipher",  "debug",  "define",  "deconstruct",  "delay",  "delete",  "density",  "depth",  "despeckle",  "direction",  "display",  "dispose",  "distort",  "distribute-cache",  "dither",  "draw",  "duplicate",  "edge",  "emboss",  "encipher",  "encoding",  "endian",  "enhance",  "equalize",  "evaluate",  "evaluate-sequence",  "extent",  "extract",  "family",  "features",  "fft",  "fill",  "filter",  "flatten",  "flip",  "floodfill",  "flop",  "font",  "format",  "frame",  "function",  "fuzz",  "fx",  "gamma",  "gaussian-blur",  "geometry",  "gravity",  "grayscale",  "green-primary",  "help",  "hough-lines",  "identify",  "ifft",  "implode",  "insert",  "intensity",  "intent",  "interlace",  "interline-spacing",  "interpolate",  "interword-spacing",  "kerning",  "kuwahara",  "label",  "lat",  "layers",  "level",  "limit",  "linear-stretch",  "liquid-rescale",  "log",  "loop",  "mask",  "mattecolor",  "median",  "mean-shift",  "metric",  "mode",  "modulate",  "monitor",  "monochrome",  "morph",  "morphology",  "motion-blur",  "negate",  "noise",  "normalize",  "opaque",  "ordered-dither",  "orient",  "page",  "paint",  "perceptible",  "ping",  "pointsize",  "polaroid",  "poly",  "posterize",  "precision",  "preview",  "print",  "process",  "profile",  "quality",  "quantize",  "quiet",  "radial-blur",  "raise",  "random-threshold",  "red-primary",  "regard-warnings",  "region",  "remap",  "render",  "repage",  "resample",  "resize",  "respect-parentheses",  "roll",  "rotate",  "sample",  "sampling-factor",  "scale",  "scene",  "seed",  "segment",  "selective-blur",  "separate",  "sepia-tone",  "set",  "shade",  "shadow",  "sharpen",  "shave",  "shear",  "sigmoidal-contrast",  "size",  "sketch",  "smush",  "solarize",  "splice",  "spread",  "statistic",  "strip",  "stroke",  "strokewidth",  "stretch",  "style",  "swap",  "swirl",  "synchronize",  "texture",  "threshold",  "thumbnail",  "tile",  "tile-offset",  "tint",  "transform",  "transparent",  "transparent-color",  "transpose",  "transverse",  "treedepth",  "trim",  "type",  "undercolor",  "unique-colors",  "units",  "unsharp",  "verbose",  "version",  "view",  "vignette",  "virtual-pixel",  "wave",  "weight",  "white-point",  "white-threshold", "write"]

  AVAILABLE_METHODS.each do |action|
    define_method("#{action}_image") do |*args|
      method_called = action
      style_keys.each do |style|
        self.process(style, method_called, *args)
      end
    end
  end

  AVAILABLE_METHODS.each do |action|
    define_method("self.#{action}_image") do |*args|
      method_called = action
      style_keys.each do |style|
        self.process(style, method_called, *args)
      end
    end
  end

  AVAILABLE_METHODS.each do |action|
    define_method("#{action}_image!") do |*args|
      method_called = action
      all_style_keys.each do |style|
        self.process(style, method_called, *args)
      end
    end
  end

  AVAILABLE_METHODS.each do |action|
    define_method("self.#{action}_image!") do |*args|
      method_called = action
      all_style_keys.each do |style|
        self.process(style, method_called, *args)
      end
    end
  end

  def style_original
    :original
  end

  # returns an array of model's paperclip keys, excluding the :original'
  def style_keys
    self.paperclip_image.styles.keys
  end

  def all_style_keys
    style_keys + [style_original]
  end

  def process(style, method_called, *args)
    path = self.paperclip_image.path(style)
    source = MiniMagick::Image.open(path)
    source = source.send(method_called, *args)
    source.write(path)
  end
end
