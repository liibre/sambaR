
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sambaR

<!-- badges: start -->
<!-- badges: end -->

Download and translate songs from the Genius database and the google
translate API. This package was created out of saudade to explain some
samba lyrics to our friends in the US, but can be used to translate any
lyrics available in the Genius database. Say you like Turkish music but
don’t understand 99.7% of the lyrics (random example).

This is basically package `genius` meets package `googleLanguageR` and I
thank everybody involved.

The API for google translate must be configured, first in the cloud,
then downloading the secret key in JSON format and saving it somewhere,
then configuring .Renviron (usually in `~/.Renviron`) with

`GL_AUTH=path_to_that_json_file.json`

The package with autenthicate automatically when loading.

I’ll try to detail this step better in the future but everything is in
the `googleLanguageR` package documentation.

## Installation

You can install the released version of sambaR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("sambaR")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("AndreaSanchezTapia/sambaR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
devtools::load_all()
#library(sambaR)
library(googleLanguageR)
```

``` r
## basic example code
hoje <- sambaR::translate_lyrics(
  artist = "caetano veloso",
  song = "é hoje",
  target = "es",
  destdir = "inst/shiny-examples/sambaR"
)
#> 
#> ── Column specification ────────────────────────────────────────────────────────
#> cols(
#>   track_title = col_character(),
#>   line = col_double(),
#>   lyric = col_character()
#> )
#> 
#> ── Column specification ────────────────────────────────────────────────────────
#> cols(
#>   translatedText = col_character(),
#>   detectedSourceLanguage = col_character(),
#>   text = col_character()
#> )
```

The function will return a two-column tibble with the lyrics and the
translated lyrics.

``` r
hoje
#> # A tibble: 24 x 2
#>    lyric                                translation                           
#>    <chr>                                <chr>                                 
#>  1 A minha alegria atravessou o mar     Mi alegría cruzó el mar               
#>  2 E ancorou na passarela               Y anclado en la pasarela              
#>  3 Fez um desembarque fascinante        Hizo un aterrizaje fascinante         
#>  4 No maior show da terra               En el espectáculo más grande del mundo
#>  5 Será que eu serei o dono dessa festa ¿Seré el dueño de esta fiesta?        
#>  6 Um rei                               Un rey                                
#>  7 No meio de uma gente tão modesta     En medio de gente tan modesta         
#>  8 Eu vim descendo a serra              Bajé de la montaña                    
#>  9 Cheio de euforia para desfilar       Lleno de euforia para desfilar        
#> 10 O mundo inteiro espera               El mundo entero espera                
#> # … with 14 more rows
```

I should add some error checks in case Genius doesn’t find the lyrics.
Bear in mind that Genius doesn’t care about capitalization but it does
about spelling *but* it does not work well with some non-ascii
characters, so avoid accents and ç.

Lastly, the search will automatically create a subfolder with the
artist’s name and the lyrics, inside `destdir` (default: current wd).
This is not optional for now and intends to avoid repeated queries to
both Genius and google translate.

## Shiny app

A Shiny app was deployed and is available by running function
`runExample()` or at <https://andreasancheztapia.shinyapps.io/sambaR/>
