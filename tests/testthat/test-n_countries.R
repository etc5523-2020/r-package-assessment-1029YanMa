test_that("output correctness test", {
  x <- coronavirus_wide
  expect_equal(
    n_countries(x),
    189
  )

  x <- dplyr::filter(coronavirus_wide, country == c("Chile", "Bolivia"))
  expect_equal(
    n_countries(x),
    2
  )
})
