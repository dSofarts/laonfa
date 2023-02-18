package com.dsofarts.laonfa.controller;

import com.dsofarts.laonfa.model.Product;
import com.dsofarts.laonfa.service.ProductService;
import com.dsofarts.laonfa.service.UserService;
import java.io.IOException;
import java.security.Principal;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final UserService userService;

    @GetMapping("/")
    public String product(@RequestParam(name = "title", required = false) String title,
            Model model, Principal principal) {
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal)  {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1,
            @RequestParam("file2") MultipartFile file2, @RequestParam("file3") MultipartFile file3,
            Product product, Principal principal) throws IOException {
        productService.saveProduct(principal, product, file1, file2, file3);
        return "redirect:/";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.delete(id);
        return "redirect:/";
    }
}
