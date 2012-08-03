require 'rake'

home_dir = ENV['HOME']
current_dir = File.dirname(__FILE__)

desc 'Update and build all Vim plugin bundles'
task :default => 'bundles:distupdate'

namespace :vim do
  desc 'Symlink config and create the tmp dir'
  task :setup do
    puts 'Symlinking .vimrc...'
    system "ln -Fins #{current_dir}/.vimrc #{home_dir}/.vimrc"
    puts 'Creating tmp directory...'
    system "mkdir #{current_dir}/tmp"
  end
   
end

namespace :vundle do
  desc 'Install Vundle'
  task :install do
    puts '== Installing Vundle...'
    system 'git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle'
  end
end

namespace :bundles do
  task :cd do
    cd File.join(File.dirname(__FILE__), 'bundle')
  end

  desc 'Purge any unmanaged bundles from the bundle dir'
  task :clean do
    puts '== Cleaning unmanaged bundles...'
    system 'vim +BundleClean +q'
  end

  desc 'Install all Vim plugin bundles'
  task :install do
    puts '== Installing all Vundle-managed plugins...'
    system 'vim -c +BundleInstall +q'
  end

  desc 'Update specified bundles, or default to all'
  task :update, :bundle do |task, args|
    bundle = args[:bundle] || ''  # all
    puts '== Updating Vundle-managed plugins...'
    system "vim -c 'BundleInstall! #{bundle}' +BundleClean +q"
  end

  desc 'Post-install steps -- compilation, etc.'
  task :build => :cd do
    puts '== Building command-t plugin'
    cd('command-t') do
      system '/usr/bin/rake make'
    end
    puts '== Installing snipmate snippets'
    cd('snipmate-snippets') do
      system 'rake deploy_local'
    end
  end

  desc 'Update and build all Vim plugin bundles'
  task :distupdate => [:update, :build]

end
