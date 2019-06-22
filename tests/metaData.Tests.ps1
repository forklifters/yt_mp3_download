Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *
Import-Module ./modules/MetaData.psm1

function testMetaData($testcases) {

    $testcases.Keys | % {
        "key = $_ , value = " + $testcases.Item($_)
        $correctResults = $testcases.Item($_)
        $results = ExtractMetaData $_

        it $_ {
            $results['artist'] | should be $correctResults['artist']
            $results['title'] | should be $correctResults['title']
        }
    }
}

describe 'Simple extraction' {

    testMetaData @{
     'Will Smith - Miami'=@{'artist'='Will Smith';'title'='Miami'}
     'Green Day - American Idiot'=@{'artist'='Green Day';'title'='American Idiot'}
     'Cher - Believe'=@{'artist'='Cher';'title'='Believe'}
     'Motorhead - Ace of Spades'=@{'artist'='Motorhead';'title'='Ace of Spades'}
     'Against Me! - Transgender Dysphoria Blues'=@{'artist'='Against Me!';'title'='Transgender Dysphoria Blues'}
     'Supergrass - In It For The Money'=@{'artist'='Supergrass';'title'='In It For The Money'}
     'Dixie Chicks - Wide Open Spaces'=@{'artist'='Dixie Chicks';'title'='Wide Open Spaces'}
     'Spiritualized - Ladies and Gentleman We Are Floating in Space'=@{'artist'='Spiritualized';'title'='Ladies and Gentleman We Are Floating in Space'}
    }
}

describe 'Move [ft.] section' {

    testMetaData @{
     'Owen Westlake - I Can Feel It (feat. Graciellita)'=@{'artist'='Owen Westlake ft. Graciellita';'title'='I Can Feel It'}
     'Alison Wonderland - U Don''t Know ft. Wayne Coyne'=@{'artist'='Alison Wonderland ft. Wayne Coyne';'title'='U Don''t Know'}
     '2Scratch - DEJA VU (ft. Prznt)'=@{'artist'='2Scratch ft. Prznt';'title'='DEJA VU'}  
     'FILV X Beatmount - Dark Sun (Feat. SEQ) | #GANGSTERMUSIC'=@{'artist'='FILV X Beatmount ft. SEQ';'title'='Dark Sun | #GANGSTERMUSIC'} 
     'Super Sako feat. Hayko - Mi Gna (Consoul Trainin Remix)'=@{'artist'='Super Sako ft. Hayko';'title'='Mi Gna (Consoul Trainin Remix)'}  
     'Lane 8 - Hold On feat. Fractures (Ben Böhmer Remix)'=@{'artist'='Lane 8 ft. Fractures';'title'='Hold On (Ben Böhmer Remix)'}   
    }
}

describe 'Filter unnecessary sections' {

    testMetaData @{
     'Vintage & Morelli x Brandon Mignacca - Bloom (Official Lyric Video)'=@{'artist'='Vintage & Morelli x Brandon Mignacca';'title'='Bloom'}
     'Delta Heavy - Ghost (Official Video)'=@{'artist'='Delta Heavy';'title'='Ghost'}
     'Bixel Boys ft. Jarell Perry - Love Marks (Original Mix)'=@{'artist'='Bixel Boys ft. Jarell Perry';'title'='Love Marks'}
     'The Cardigans - My Favourite Game (HIGH QUALITY)'=@{'artist'='The Cardigans';'title'='My Favourite Game'}
     'Parra for Cuva - Cupa Cupa (Official Video)'=@{'artist'='Parra for Cuva';'title'='Cupa Cupa'}
     'Morandi ft. Kati - Love me [HD]'=@{'artist'='Morandi ft. Kati';'title'='Love me'}
    }
}

describe 'Complex parsing' {

    testMetaData @{
     'Marshmello - Here With Me Feat. CHVRCHES (Official Music Video)'=@{'artist'='Marshmello ft. CHVRCHES';'title'='Here With Me'}
     'will.i.am - Scream & Shout ft. Britney Spears (Official Music Video)'=@{'artist'='will.i.am ft. Britney Spears';'title'='Scream & Shout'}
    }
}
