# === EDITOR ===
Pry.config.editor = ENV['PRY_EDITOR'] || 'code'

# === PROMPT ===
Pry.config.prompt_name = begin
  current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
  current_branch = "#{current_branch[0..14]}.." if current_branch.length > 16

  prompt_name = ENV['APP_NAME'] || File.basename(Rails.root)
  prompt_name << "#{Rails.env.to_s.first}" unless Rails.env.development?
  prompt_name << " (#{current_branch})"
  prompt_name
end

Pry.config.prompt = [
    # Default
    -> (target_self, nest_level, pry) {
      prompt = "[#{pry.input_array.size}]"
      prompt << " #{Pry.config.prompt_name}:"
      prompt << " #{Pry.view_clip(target_self)}"
      prompt << "#{":#{nest_level}" unless nest_level.zero?}> "
      prompt
    },

    # Nested under def, class etc.
    ->(target_self, nest_level, pry) {
      default_prompt = Pry.config.prompt[0].call(target_self, nest_level, pry)
      prompt = (' ' * default_prompt.length)[0...-(pry.input_array.size.to_s.length + 4)]
      prompt << " #{pry.input_array.size} "
      prompt << '> '
      prompt
    }
]

# === COLORS ===
unless ENV['PRY_BW']
  Pry.color = true
  Pry.config.theme = "tomorrow"
end

# === HISTORY ===
Pry.config.history_file = "~/.irb_history"
Pry.config.history_save = true
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

# == Pry-Nav - Using pry as a debugger ==
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'f', 'finish' rescue nil
Pry.commands.alias_command 'l', 'whereami' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

# === Listing config ===
# Better colors - by default the headings for methods are too
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme
# for your terminal
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# == PLUGINS ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
begin
  require 'awesome_print'
  # The following line enables awesome_print for all pry output,
  # and it also enables paging
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}

  # If you want awesome_print without automatic pagination, use the line below
  module AwesomePrint
    Formatter.prepend(Module.new do
      def awesome_self(object, type)
        if type == :string && @options[:string_limit] && object.inspect.to_s.length > @options[:string_limit]
          colorize(object.inspect.to_s[0..@options[:string_limit]] + "...", type)
        else
          super(object, type)
        end
      end
    end)
  end

  AwesomePrint.defaults = {
    :string_limit => 80,
    :indent => 2,
    :multiline => true
  }
  AwesomePrint.pry!
rescue LoadError => err
  puts "gem install awesome_print  # <-- highly recommended"
end

# === COLOR CUSTOMIZATION ===
# Everything below this line is for customizing colors, you have to use the ugly
# color codes, but such is life.
CodeRay.scan("example", :ruby).term # just to load necessary files
# Token colors pulled from: https://github.com/rubychan/coderay/blob/master/lib/coderay/encoders/terminal.rb

$LOAD_PATH << File.dirname(File.realpath(__FILE__))
