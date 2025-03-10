package pl.dmcs.configuration;

import jakarta.annotation.Resource;
import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfiguration {

    @Resource(name="myAppUserDetailsService")
    private UserDetailsService userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    DaoAuthenticationProvider authProvider(){
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        // for database users
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        // for in-memory users
//        authProvider.setUserDetailsService(userDetailsService());
        return authProvider;
    }

//    @Bean
//    public InMemoryUserDetailsManager userDetailsService() {
//        UserDetails user = User.withDefaultPasswordEncoder()
//                .username("user")
//                .password("user")
//                .roles("USER")
//                .build();
//        UserDetails admin = User.withDefaultPasswordEncoder()
//                .username("admin")
//                .password("admin")
//                .roles("ADMIN","USER")
//                .build();
//        UserDetails student = User.withDefaultPasswordEncoder()
//                .username("student")
//                .password("student")
//                .roles("STUDENT")
//                .build();
//        return new InMemoryUserDetailsManager(user, admin, student);
//    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        http.addFilterBefore(filter, CsrfFilter.class);

        http
                .authorizeHttpRequests((authz) -> authz
                        .requestMatchers("/resources/**").permitAll()
                        .requestMatchers("/search*").permitAll()
                        .requestMatchers("/searchSubmit*").permitAll()
                        .requestMatchers("/details*").permitAll()
                        .requestMatchers("/appointments*").hasAuthority("ROLE_USER")
                        .requestMatchers("/prescriptions*").hasAuthority("ROLE_USER")
                        .requestMatchers("/prescriptionsForm*").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/appUsers*").hasAnyRole("ADMIN","USER")
                        .requestMatchers("/appUserRole*").hasRole("ADMIN")
                        .requestMatchers("/exampleOne*").hasAuthority("ROLE_USER")
                        .requestMatchers("/exampleTwo*").hasAnyAuthority("ROLE_STUDENT", "ROLE_ADMIN")
                        .requestMatchers("/exampleThree*").hasRole("STUDENT")
                        .requestMatchers("/admin-panel*").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/doctor-view*").anonymous()
                        .requestMatchers("/chat*").anonymous()
                        .requestMatchers("/login*").anonymous()
                        .requestMatchers("/register*").anonymous()
                        .requestMatchers("/confirm*").anonymous()
                        .requestMatchers("/*").permitAll()
                        .anyRequest().authenticated()
                        .and()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .usernameParameter("login")
                        .passwordParameter("password")
                        .failureUrl("/login?error")
                        .defaultSuccessUrl("/",true) //use wisely
                        .permitAll()
                        .and()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()
                        .and()
                )
                .exceptionHandling(accessDenied -> accessDenied
                        .accessDeniedPage("/accessDenied")
                        .and()
                )
                .httpBasic();
        return http.build();
    }

}













