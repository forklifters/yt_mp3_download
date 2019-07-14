# Run from the project root directory as 'Invoke-Pester ./tests/metaData.Tests.ps1'

Import-Module ./modules/metaData.psm1


function testMetaData($testcases) {

    $testcases.Keys | % {
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
     'Nu:Logic - Morning Light'=@{'artist'='Nu:Logic';'title'='Morning Light'}
     'Spiritualized - Ladies and Gentleman We Are Floating in Space'=@{'artist'='Spiritualized';'title'='Ladies and Gentleman We Are Floating in Space'}
     'Surface - Falling In Love (12" Extended Mix)'=@{'artist'='Surface';'title'='Falling In Love (12" Extended Mix)'}
     'Delegation - It''s Your Turn'=@{'artist'='Delegation';'title'='It''s Your Turn'}
     'Kenna - War in Me'=@{'artist'='Kenna';'title'='War in Me'}
     'Nils Hoffmann - Drift (Ben Böhmer Remix)'=@{'artist'='Nils Hoffmann';'title'='Drift (Ben Böhmer Remix)'}
     'L.A.O.S - Back No More'=@{'artist'='L.A.O.S';'title'='Back No More'}
     'Lieon - F.A.I.T.H.'=@{'artist'='Lieon';'title'='F.A.I.T.H.'}
     'Møme vs. Midnight To Monaco - Alive'=@{'artist'='Møme vs. Midnight To Monaco';'title'='Alive'}
     'SHDØW - Spirit.'=@{'artist'='SHDØW';'title'='Spirit.'}
     'EDX - Omertà'=@{'artist'='EDX';'title'='Omertà'}
     'Au/Ra - Panic Room'=@{'artist'='Au/Ra';'title'='Panic Room'}
     '1991 - Illusions'=@{'artist'='1991';'title'='Illusions'}
     'MØ - Walk This Way'=@{'artist'='MØ';'title'='Walk This Way'}
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
	 'Gorgon City (feat. Katy Menditta) - Imagination'=@{'artist'='Gorgon City ft. Katy Menditta';'title'='Imagination'}
	 'Pomo - Start Again (feat. Andrea Cormier)'=@{'artist'='Pomo ft. Andrea Cormier';'title'='Start Again'}
     'BCee - Typical Description (Ft. David Boomah) (Calibre Remix)'=@{'artist'='BCee ft. David Boomah';'title'='Typical Description (Calibre Remix)'}
     'Brains feat. Sian Evans - We Are One (Chris.SU Remix)'=@{'artist'='Brains ft. Sian Evans';'title'='We Are One (Chris.SU Remix)'}
     'Kaster - Neverending (feat. Qwentalis)'=@{'artist'='Kaster ft. Qwentalis';'title'='Neverending'}
     'Cosmic Gate feat. Tiff Lacey - Open Your Heart (Yuri Kane Remix)'=@{'artist'='Cosmic Gate ft. Tiff Lacey';'title'='Open Your Heart (Yuri Kane Remix)'}
     'M83 (feat. Susanne Sundfør) - Oblivion'=@{'artist'='M83 ft. Susanne Sundfør';'title'='Oblivion'}
     'Schiller feat. September - Breathe'=@{'artist'='Schiller ft. September';'title'='Breathe'}
     'Axel Boy (feat. Natalie Holmes) - Noughts & Crosses'=@{'artist'='Axel Boy ft. Natalie Holmes';'title'='Noughts & Crosses'}
     'Helsloot feat. Freya - Rain'=@{'artist'='Helsloot ft. Freya';'title'='Rain'}
     'Cartoon (ft. Coleman Trapp) - Why We Lose'=@{'artist'='Cartoon ft. Coleman Trapp';'title'='Why We Lose'}
     'Dimension (ft. Raphaella) - Pull Me Under'=@{'artist'='Dimension ft. Raphaella';'title'='Pull Me Under'}
     'K Flay feat. Sol & Buddy - Make Me Fade'=@{'artist'='K Flay ft. Sol & Buddy';'title'='Make Me Fade'}
     'Nitro Fun feat. Aviana - Fading Away'=@{'artist'='Nitro Fun ft. Aviana';'title'='Fading Away'}
     'Pherotone feat. Magnus - Silence Is Golden (Medsound Remix)'=@{'artist'='Pherotone ft. Magnus';'title'='Silence Is Golden (Medsound Remix)'}
     'Alok Dazzo feat. Barja - Deep Inside'=@{'artist'='Alok Dazzo ft. Barja';'title'='Deep Inside'}
     'Loosid feat. Raycee Jones - Clouds'=@{'artist'='Loosid ft. Raycee Jones';'title'='Clouds'}
     'ARMA feat. Odissi - Ostem'=@{'artist'='ARMA ft. Odissi';'title'='Ostem'}
     'The Glitch Mob (ft. Metal Mother) - Becoming Harmonious'=@{'artist'='The Glitch Mob ft. Metal Mother';'title'='Becoming Harmonious'}
     'Spor (ft. Tasha Baxter) - Overdue'=@{'artist'='Spor ft. Tasha Baxter';'title'='Overdue'}
     'Kaskade feat. Mindy Gledhill - Say Its Over'=@{'artist'='Kaskade ft. Mindy Gledhill';'title'='Say Its Over'}
     'Kat Krazy feat. elkka - Siren (Extended Mix)'=@{'artist'='Kat Krazy ft. elkka';'title'='Siren (Extended Mix)'}
     'Joywave - Tongues (ft. Kopps) (RAC Mix)'=@{'artist'='Joywave ft. Kopps';'title'='Tongues (RAC Mix)'}
     'Mr. FijiWiji - Submerged (ft. CoMa)'=@{'artist'='Mr. FijiWiji ft. CoMa';'title'='Submerged'}
     'Bulb - Still There (Feat. Mc Fava)'=@{'artist'='Bulb ft. Mc Fava';'title'='Still There'}
     'Tube & Berger feat. Juliet Sikora - Come On Now'=@{'artist'='Tube & Berger ft. Juliet Sikora';'title'='Come On Now'}
     'Moonbeam feat. Leusin - Daydream (Radio Mix)'=@{'artist'='Moonbeam ft. Leusin';'title'='Daydream (Radio Mix)'}
     'Maduk - Life feat. Hebe Vrijhof'=@{'artist'='Maduk ft. Hebe Vrijhof';'title'='Life'}
     'Seba & Paradox (Feat. Kirsty Hawkshaw) - The Light'=@{'artist'='Seba & Paradox ft. Kirsty Hawkshaw';'title'='The Light'}
     'TMS - I Need You (Ft. Jagga) (Shock One Remix) '=@{'artist'='TMS ft. Jagga';'title'='I Need You (Shock One Remix)'}
     'Dorincourt - Symphony (Feat. Mya Ferron)'=@{'artist'='Dorincourt ft. Mya Ferron';'title'='Symphony'}
     'Serge Devant feat. Jaren - No Good'=@{'artist'='Serge Devant ft. Jaren';'title'='No Good'}
     'Mr. FijiWiji - Yours Truly (feat. Danyka Nadeau)'=@{'artist'='Mr. FijiWiji ft. Danyka Nadeau';'title'='Yours Truly'}
     'Disclosure - White Noise ft. AlunaGeorge'=@{'artist'='Disclosure ft. AlunaGeorge';'title'='White Noise'}
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
     'Shakira - Loca [MUSIC VIDEO]'=@{'artist'='Shakira';'title'='Loca'}
    }
}

describe 'Complex parsing' {

    testMetaData @{
     'Marshmello - Here With Me Feat. CHVRCHES (Official Music Video)'=@{'artist'='Marshmello ft. CHVRCHES';'title'='Here With Me'}
     'will.i.am - Scream & Shout ft. Britney Spears (Official Music Video)'=@{'artist'='will.i.am ft. Britney Spears';'title'='Scream & Shout'}
     'Burak Yeter - Tuesday ft. Danelle Sandoval (Audio)'=@{'artist'='Burak Yeter ft. Danelle Sandoval';'title'='Tuesday'}
	 'Mario Basanov feat. Rahjwanti - Slip Away (Original Mix)'=@{'artist'='Mario Basanov ft. Rahjwanti';'title'='Slip Away'}
	 'TyDi - Talking To Myself feat. DJ Rap (Original Mix)'=@{'artist'='TyDi ft. DJ Rap';'title'='Talking To Myself'}
	 'Matt Darey & Aeron Aether Feat. Tiff Lacey - Into The Blue (Original Mix)'=@{'artist'='Matt Darey & Aeron Aether ft. Tiff Lacey';'title'='Into The Blue'}
	 'Rey & Kjavik feat. Mazefive - Dont Be Afraid (Original Mix)'=@{'artist'='Rey & Kjavik ft. Mazefive';'title'='Dont Be Afraid'}
    }
}

describe 'Incomplete extraction' {

    testMetaData @{
     '-_ -;'=@{'artist'='';'title'=''}
     ' - '=@{'artist'='';'title'=''}
     ' - XXX'=@{'artist'='';'title'='XXX'}
     'A- A'=@{'artist'='A- A';'title'='A- A'}
     'A -A'=@{'artist'='A -A';'title'='A -A'}
     'XXX - '=@{'artist'='XXX';'title'='XXX'}
     'Losing My Mind'=@{'artist'='Losing My Mind';'title'='Losing My Mind'}
     'Gorgon City - feat. MNEK'=@{'artist'='Gorgon City ft. MNEK';'title'=''}
    }
}
