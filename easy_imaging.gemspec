# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_imaging/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_imaging"
  spec.version       = EasyImaging::VERSION
  spec.authors       = ["Hethe Berg"]
  spec.email         = ["growthcode@gmail.com"]

  spec.summary       = %q{Ruby on Rails gem which grants easy to use instance methods for image manipulation to models using the Paperclip gem.}
  spec.description   = %q{If you are using the Paperclip Gem to store your files but would also like to be able to run manipulate the images in your app, then this is the easiest Gem to get you started. You can use any of the ImageMagick (or even Graphicsmagick) methods. Find a list of image manipulation options here: http://www.imagemagick.org/script/command-line-options.php.}
  spec.homepage      = "http://github.com/growthcode/easy_imaging"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mini_magick", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
