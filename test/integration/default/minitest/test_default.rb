require 'minitest/autorun'

describe 'check R version' do
  it "check R version" do
    system('R CMD BATCH showversion.R')
    assert system('grep "R version 3.1.0 (2014-04-10) -- \"Spring Dance\"" showversion.Rout'), 'R version is not expected version. maybe r-base package is updated'
  end
end

describe 'check Bioconductor version' do
  it "check Bioconductor version" do
    system('R CMD BATCH showBioconductorVersion.R')
    # develop
    #assert system('grep "Bioconductor version 3.0 (BiocInstaller 1.15.3)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
    # stable
    assert system('grep "Bioconductor version 2.14 (BiocInstaller 1.14.2)" showBioconductorVersion.Rout'), 'Bioconductor version is not expected version. maybe Bioconductor package is updated'
  end
end
