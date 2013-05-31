package com.mitchbarry.glassware.magiccrystalprism.entities;

import com.google.api.client.util.DateTime;

/**
 * User Class
 * @author Mitchell Barry - http://plus.google.com/109697731481348133983
 * Date: 5/31/13
 */

public class User {

    private String userId;
    private DateTime authorizedDate;
    private int activityCount;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public DateTime getAuthorizedDate() {
        return authorizedDate;
    }

    public void setAuthorizedDate(DateTime authorizedDate) {
        this.authorizedDate = authorizedDate;
    }

    public int getActivityCount() {
        return activityCount;
    }

    public void setActivityCount(int activityCount) {
        this.activityCount = activityCount;
    }
}
