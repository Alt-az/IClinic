package pl.dmcs.service;

import pl.dmcs.domain.Address;

import java.util.List;

public interface AddressService {
    void addAddress(Address address);
    void editAddress(Address address);
    List<Address> listAddress();
    void removeAddress (long id);
    Address getAddress(long id);
}
