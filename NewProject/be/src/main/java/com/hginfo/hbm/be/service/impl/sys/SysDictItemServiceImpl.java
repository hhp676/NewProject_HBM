/*
 * Project Name:hbm-be.
 * File Name:SysDictItemServiceImpl.java
 * Package Name:com.hginfo.hbm.be.service.impl.sys
 * Date:2016年11月29日 下午3:43:44
 * Copyright (c) 2016, hongguaninfo.com All Rights Reserved.
 *
 */
package com.hginfo.hbm.be.service.impl.sys;

import java.util.List;
import java.util.OptionalInt;
import java.util.stream.IntStream;

import org.springframework.stereotype.Service;

import com.hginfo.hbm.base.entity.sys.SysDictItem;
import com.hginfo.hbm.be.dao.sys.SysDictItemDao;
import com.hginfo.hbm.be.service.base.BizService;

/**
* 系统字典项表: sys_dict_item. <br />
* service impl 层 <br />
* Date: 2016年11月29日 下午3:43:44 <br />
*
* @author qiujingde
* @since V1.0.0
*/
@Service
public class SysDictItemServiceImpl extends BizService<SysDictItem, SysDictItemDao> {

    /**
     *
     */
    private static final int LONG_SIZE = 64;

    /**
     * 同步锁。
     */
    private final Object lock = new Object();

    @Override
    public void add(SysDictItem sysDictItem) {
        synchronized (lock) {
            sysDictItem.setPriorityNo(getNextPriority(sysDictItem));
            super.add(sysDictItem);
        }
    }

    @Override
    public void update(SysDictItem sysDictItem) {
        super.update(sysDictItem);
    }

    /**
     * 获取下一个可用权重。
     * @param item 新增item
     * @return 可用权重。
     */
    private long getNextPriority(SysDictItem item) {
        SysDictItem filter = new SysDictItem();
        filter.setIsDelete(0);
        filter.setDictGroupId(item.getDictGroupId());

        List<SysDictItem> items = getList(filter);
        long usedPriority = items.stream()
                .mapToLong(SysDictItem::getPriorityNo)
                .reduce(0L, (x, y) -> x | y);

        OptionalInt availableShift = IntStream.range(0, LONG_SIZE)
                .filter(i -> (usedPriority & (1 << i)) == 0)
                .findFirst();
        return availableShift.isPresent() ? 1 << availableShift.getAsInt() : 0;
    }

}
