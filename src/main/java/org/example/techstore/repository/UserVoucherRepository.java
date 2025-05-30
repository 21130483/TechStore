package org.example.techstore.repository;

import org.example.techstore.model.User;
import org.example.techstore.model.UserVoucher;
import org.example.techstore.model.UserVoucherId;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface UserVoucherRepository extends CrudRepository<UserVoucher, UserVoucherId> {

    List<UserVoucher> findByUser(User user);

    List<UserVoucher> findByVoucherVoucherID(Integer voucherID);
}
