test_that("input test", {
  expect_error(launch_dt(sometext))
  expect_error(launch_dt(1234))
})
