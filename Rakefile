require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new do |t|
  t.files = Dir["lib/**/*.rb"]
end

desc "Run tests and generate docs"
task default: [:spec]

desc "Document the library"
task doc: [:yard]

desc "Bootstrap"
namespace(:bootstrap) do
  desc 'Copy the .ruby-gemset file'
  task :ruby_gemset do
    source_file      = File.expand_path('../.ruby-gemset.sample', __FILE__)
    destination_file = File.expand_path('../.ruby-gemset', __FILE__)

    command = "cp %s %s" % [source_file, destination_file]

    if File.exists?(destination_file)
      puts "Skipping %s, file exists..." % [command]
    else
      puts "Executing %s" % [command]
      system(command)
    end
  end

  desc 'Copy the .ruby-version file'
  task :ruby_version do
    source_file      = File.expand_path('../.ruby-version.sample', __FILE__)
    destination_file = File.expand_path('../.ruby-version', __FILE__)

    command = "cp %s %s" % [source_file, destination_file]

    if File.exists?(destination_file)
      puts "Skipping %s, file exists..." % [command]
    else
      puts "Executing %s" % [command]
      system(command)
    end
  end

  desc 'Bundle Install'
  task :bundle do
    command = 'bundle install'
    puts "Executing %s" % [command]
    system(command)
  end

  desc 'Copy the .env file'
  task :env do
    source_file      = File.expand_path('../.env.sample', __FILE__)
    destination_file = File.expand_path('../.env', __FILE__)

    command = "cp %s %s" % [source_file, destination_file]

    if File.exists?(destination_file)
      puts "Skipping %s, file exists..." % [command]
    else
      puts "Executing %s" % [command]
      system(command)
    end
  end

  desc 'Bootstrap All'
  task all: [:ruby_version, :ruby_gemset, :env, :bundle] do
  end
end

desc "Interactive Console"
task :console do
  command = "bundle console"
  puts "Loading Automatic gem (%s)..." % [command]
  system(command)
end
