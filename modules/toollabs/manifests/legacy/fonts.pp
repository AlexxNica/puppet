# Copy of mediawiki::packages::fonts when it still ran on Precise.
# Won't get updated, is just for precise.
#
class toollabs::legacy::fonts {
    requires_os('ubuntu precise')

    package { [
        'fonts-arabeyes',
        'fonts-arphic-ukai',
        'fonts-arphic-uming',
        'fonts-farsiweb',
        'fonts-kacst',
        'fonts-khmeros',
        'fonts-lao',
        'fonts-liberation',
        'fonts-linuxlibertine',
        'fonts-manchufont',
        'fonts-mgopen',
        'fonts-nafees',
        'fonts-sil-abyssinica',
        'fonts-sil-ezra',
        'fonts-sil-padauk',
        'fonts-sil-scheherazade',
        'fonts-takao-gothic',
        'fonts-takao-mincho',
        'fonts-thai-tlwg',
        'fonts-tibetan-machine',
        'fonts-unfonts-core',
        'fonts-unfonts-extra',
        'texlive-fonts-recommended',
        'ttf-alee',
        'ttf-bengali-fonts',
        'ttf-devanagari-fonts',
        'ttf-gujarati-fonts',
        'ttf-kannada-fonts',
        'ttf-malayalam-fonts',
        'ttf-oriya-fonts',
        'ttf-punjabi-fonts',
        'ttf-tamil-fonts',
        'ttf-telugu-fonts',
        'ttf-ubuntu-font-family',
        'ttf-wqy-zenhei',
        'xfonts-100dpi',
        'xfonts-75dpi',
        'xfonts-base',
        'xfonts-mplus',
        'xfonts-scalable',
        'fonts-sil-nuosusil',        # T83288
        'culmus',                    # T40946
        'culmus-fancy',              # T40946
        'fonts-lklug-sinhala',       # T57462
        'fonts-vlgothic',            # T66002
        'ttf-kochi-gothic',          # T66002
        'ttf-kochi-mincho',          # T66002
    ]:
        ensure => present,
    }
}
