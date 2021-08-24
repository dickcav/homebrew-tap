require 'formula'

class Tcserver < Formula
  homepage 'http://tcserver.docs.pivotal.io/index.html'
  url 'https://s3.amazonaws.com/public.pivotal.com/releases/tcserver/4.1.10.RELEASE/tcserver-4.1.10.RELEASE-developer.tar.gz'
  sha256 'd0dc8767190eea956cb72afddd32e7fbf5f9a7bead5ba4a2758e9f0855bd312d'
  version '4.1.10'

  def install
    rm_rf Dir['**/*.bat']
    distDir = "developer-#{version}.RELEASE"
    %w(README.txt licenses/VMware_EULA.txt).each do |readme|
      prefix.install ["#{distDir}/#{readme}"]
    end
    libexec.install Dir['*']
    bin.install_symlink Dir["#{libexec}/#{distDir}/tcserver"]
    tcsInstancesDir = var.join('tcserver').join('instances')
    tcsInstancesDir.mkpath
    IO.write("#{libexec}/#{distDir}/conf/tcserver.properties",
             "instances.directory=#{tcsInstancesDir}\n", mode: 'a')
  end

  def caveats; <<-EOS
    By installing, you agree to comply with the license at https://network.pivotal.io/legal_documents/vmware_eula.
    If you disagree with these terms, please uninstall by typing "brew uninstall tcserver" in your terminal window.

    Usage:
       To create a new tc Server instance:
          > tcserver create myinstance

       To control tc Server instance:
          > tcserver start|stop|restart|status myinstance

    Documentation:
       https://tcserver.docs.pivotal.io/

    Open Source License:
       https://network.pivotal.io/open-source

    For inquiries about commercial licensing, support, training, and consulting, please contact us at:
       mailto:tcserver@pivotal.io
    EOS
  end
end
