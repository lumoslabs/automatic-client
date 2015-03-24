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

desc "Interactive Console"
task :console do
  libs = []
  libs << "-r irb/completion"
  libs << "-r %s" % [File.expand_path('../lib/automatic', __FILE__)]

  cmd = "irb %s --simple-prompt" % [libs.join(' ')]

  puts "Loading automatic gem"
  system(cmd)
end
