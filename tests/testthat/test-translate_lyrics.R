test_that("translateLyrics works", {
  library(googleLanguageR)
  dirs <- tempdir()
  df <- translate_lyrics("chico buarque", "vai passar", destdir = dirs)
  expect_equal(names(df), "lyric")
})

test_that("target language works", {
  library(googleLanguageR)
  dirs <- tempdir()
  df2 <- translate_lyrics("chico buarque", "vai passar", target = "en", destdir = dirs)
  expect_equal(names(df2), c("lyric", "translation"))
})
