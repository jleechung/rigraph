
context("as.directed")

test_that("as.directed works", {
  library(igraph)
  
  g <- sample_gnp(100, 2/100)
  g2 <- as.directed(g, mode="mutual")
  g3 <- as.directed(g, mode="arbitrary")
  g4 <- as.directed(g, mode="random")
  g5 <- as.directed(g, mode="acyclic")

  expect_that(degree(g), equals(degree(g2) / 2))  
  expect_that(degree(g), equals(degree(g3)))
  expect_that(degree(g), equals(degree(g4)))
  expect_that(degree(g), equals(degree(g5)))

  expect_true(graph.isomorphic(g, as.undirected(g2)))
  expect_true(graph.isomorphic(g, as.undirected(g3)))
  expect_true(graph.isomorphic(g, as.undirected(g4)))
  expect_true(graph.isomorphic(g, as.undirected(g5)))
})

test_that("as.directed keeps attributes", {
  library(igraph)
  g <- graph_from_literal( A-B-C, D-A, E )
  g$name <- "Small graph"
  g2 <- as.directed(g, mode="mutual")
  g3 <- as.directed(g, mode="arbitrary")
  expect_that(g2$name, equals(g$name))
  expect_that(V(g2)$name, equals(V(g)$name))
  expect_that(g3$name, equals(g$name))
  expect_that(V(g3)$name, equals(V(g)$name))

  E(g)$weight <- seq_len(ecount(g))
  g4 <- as.directed(g, "mutual") ; df4 <- as_data_frame(g4)  
  g5 <- as.directed(g, "arbitrary") ; df5 <- as_data_frame(g5)
  expect_that(df4[order(df4[,1], df4[,2]),]$weight, equals(c(1,2,1,3,3,2)))
  expect_that(df5[order(df5[,1], df5[,2]),]$weight, equals(1:3))
})

