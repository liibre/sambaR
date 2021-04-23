#' Translate song lyrics 
#'
#' This function was written out of saudade to 
#' translate any lyrics available in the Genius.com platform. It will save the 
#' lyrics and the translation to avoid repeated queries to both databases
#' 
#' @param artist The quoted name of the artist. Spelling matters, capitalization
#'  does not. See `genius::genius_lyrics()`
#' @param song The quoted name of the song. Spelling matters, capitalization 
#' does not. See `genius::genius_lyrics()`
#' @param target The target language
#' @param destdir The folder to save the lyrics. Defaults to the current 
#' working directory "."
#' @param ... Other arguments for gl_translate
#'
#' @return A two-column tibble with the original and the translated lyrics
#' @importFrom genius genius_lyrics
#' @importFrom fs path  
#' @importFrom readr read_csv write_csv  
#' @importFrom googleLanguageR gl_translate
#' @importFrom tibble tibble
#' @importFrom cld2 detect_language
#' @export 
#' @examples
#' \dontrun{
#' translate_lyrics(artist = "caetano veloso", song = "é hoje")
#' translate_lyrics(artist = "caetano veloso",song = "é hoje", target = "fr")
#' translate_lyrics(artist = "charly garcia", song = "los dinosaurios", target = "fr")
#' }
translate_lyrics <- function(artist,
                             song,
                             target = NULL,
                             destdir = "~",
                             ...) {
  art_path <- fs::path(destdir, artist)
  if (!file.exists(art_path)) dir.create(art_path, recursive = T)
  song_path <- fs::path(destdir, 
                        artist,
                        song,
                        ext = "csv")
  if (!file.exists(song_path)) {
    lyric <- genius::genius_lyrics(artist, song, info = "all")
    readr::write_csv(lyric, file = song_path)
    } else {
      lyric <- readr::read_csv(song_path)
    }
  translation <- tibble::tibble(translatedText = "")
  if (!is.null(target)) {
    detected <- names(which.max(table(cld2::detect_language(lyric$lyric))))
    message("Language detected: ", detected)
    if (target != detected) {
    tr_song_path <- fs::path(destdir,
                             artist,
                             paste(song, target, sep = "_"),
                             ext = "csv")
    if (!file.exists(tr_song_path)) {
      translation <- googleLanguageR::gl_translate(lyric$lyric, target = target, ...)
      readr::write_csv(translation, file = tr_song_path)
    } 
    if (file.exists(tr_song_path))
        translation <- readr::read_csv(tr_song_path)
    return(tibble::tibble(lyric = lyric$lyric, translation = translation$translatedText))
    } else message("target language is the same as the detected language")
  } else message("no target language selected, returning lyrics")
  return(tibble::tibble(lyric = lyric$lyric))
}
