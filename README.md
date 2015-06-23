# EasyImaging

If you are using the [Paperclip Gem](http://github.com/thoughtbot/paperclip) to store your files but would also like to be able to run manipulate the images in your app, then this is the easiest Gem to get you started.

You can use any of the [ImageMagick](http://www.imagemagick.org/script/command-line-options.php) (or even Graphicsmagick) methods.

Find a list of image manipulation options here:
http://www.imagemagick.org/script/command-line-options.php

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_imaging'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_imaging


## 2 ways to use this Gem

Any of the following examples will be for a 'User' model with a Paperclip image attribute name of 'avatar'.

Example Model I'll be referencing:
```ruby

  class User < ActiveRecord::Base
    validates :avatar, presence: true

    # Paperclip details:
    has_attached_file :avatar,
        styles: {
          large: '640x480>',
          thumb: '105x105>',
          listing: '225x225>',
          general: '640x480>'
        },
        :url  => "/avatars/:class/:style/:id",
        :path => ":rails_root/public/avatars/:class/:style/:id"
  end

```


#### 1) Use it through the EasyImaging Module.


Any model instance with a Paperclip image attached can now run any of [ImageMagick's methods](http://www.imagemagick.org/script/command-line-options.php).

You have the option of applying manipulation to all the instance's style keys, or to all style keys but the original. To apply to all including the original, add a "bang" to the end of the method.

Using the ImageMagick methods are easy, the naming conventin follows a simple pattern.

```ruby
EasyImaging.#{method}_image(*args)
```

##### Apply to all styles but the original:

```ruby

  # Reflect the scanlines in the vertical direction. The image will be mirrored upside-down.
  EasyImaging.flip_image(@user.avatar)

  # Reflect the scanlines in the horizontal direction, just like the image in a vertical mirror.
  EasyImaging.flop_image(@user.avatar)

  # Rotate the picture 90 degrees counter clockwise.
  EasyImaging.rotate_image(@user.avatar, "-90")

  # Crop the image at these xy points in the picture.
  EasyImaging.crop_image(@user.avatar, "120x120+10+5")

```

##### Apply to all styles, including original:

```ruby

  # Reflect the scanlines in the vertical direction. The image will be mirrored upside-down.
  EasyImaging.flip_image!(@user.avatar)

  # Reflect the scanlines in the horizontal direction, just like the image in a vertical mirror.
  EasyImaging.flop_image!(@user.avatar)

  # Rotate the picture 90 degrees counter clockwise.
  EasyImaging.rotate_image!(@user.avatar, "-90")

  # Crop the image at these xy points in the picture.
  EasyImaging.crop_image!(@user.avatar, "120x120+10+5")

```

#### 2) Perform the image manipulation through instance methods.

You can actually apply the methods onto the Paperclip image's model and use the methods as instance methods.

You'll need to add 2 things to your model which has the image instance in order to do this. 1) 'include EasyImaging' inside your model. 2) define a paperclip_image method which returns the attribute holding your image.

For an example, I'll add the instance methods to a 'User' Model which calls it's Paperclip image attribute 'avatar'

```ruby

class User < ActiveRecord::Base

  include EasyImaging

  ...

  def paperclip_image
    avatar
  end
end

```


Once you are ready to use the instance methods:
```ruby

  # Reflect the scanlines in the vertical direction. The image will be mirrored upside-down.
  @user.flip_image

  # Reflect the scanlines in the horizontal direction, just like the image in a vertical mirror.
  @user.flop_image

  # Rotate the picture 90 degrees counter clockwise.
  @user.rotate_image("-90")

  # Crop the image at these xy points in the picture.
  @user.crop_image("120x120+10+5")

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/easy_imaging/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
