#!/usr/bin/env python2

import cv2
import rospy
import numpy as np
from quarc_user_interface.msg import vision_object

objects = {"green" : [[22, 50, 0], [56, 220, 225]],
           "blue": [[83, 95, 64], [124, 255, 255]],
           "red": [[135, 135, 0], [179, 255, 255]]}

object_publisher = rospy.Publisher('vision_objects', vision_object, queue_size=10)
rospy.init_node('quarc_vision')

def angle_cos(p0, p1, p2):
    d1, d2 = (p0-p1).astype('float'), (p2-p1).astype('float')
    return abs( np.dot(d1, d2) / np.sqrt( np.dot(d1, d1)*np.dot(d2, d2) ) )

def find_squares(img):
    img = cv2.GaussianBlur(img, (5, 5), 0)
    img = cv2.GaussianBlur(img, (5, 5), 0)
    squares = []
    for gray in cv2.split(img):
    # for gray in [cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)]:
        for thrs in xrange(0, 255, 26):
            if thrs == 0:
                bin = cv2.Canny(gray, 0, 50)
                bin = cv2.dilate(bin, None)
            else:
                retval, bin = cv2.threshold(gray, thrs, 255, cv2.THRESH_BINARY)
            bin, contours, hierarchy = cv2.findContours(bin, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
            for cnt in contours:
                cnt_len = cv2.arcLength(cnt, True)
                cnt = cv2.approxPolyDP(cnt, 0.025*cnt_len, True)
                if len(cnt) == 4 and cv2.contourArea(cnt) > 1000 and cv2.isContourConvex(cnt) and cv2.contourArea(cnt) < (img.shape[0] * img.shape[1])*.90:
                    cnt = cnt.reshape(-1, 2)
                    max_cos = np.max([angle_cos( cnt[i], cnt[(i+1) % 4], cnt[(i+2) % 4] ) for i in xrange(4)])
                    if max_cos < 0.1:
                        squares.append(cnt)
    return squares

cap = cv2.VideoCapture(0)

while(1):
    _, img = cap.read()

    # # --- square finding ---
    edges = find_squares(img)
    edges = (x for x in edges if lambda x: cv2.contourArea(x) < .95*imgarea)
    edges = sorted(edges, key=cv2.contourArea, reverse=True)[:1]

    persp_img = None
    for edge in edges:
        pts = edge.reshape(4,2)
        rect = np.zeros((4,2), dtype="float32")
        s = pts.sum(axis=1)
        rect[0] = pts[np.argmin(s)]
        rect[2] = pts[np.argmax(s)]
        d = np.diff(pts, axis=1)
        rect[1] = pts[np.argmin(d)]
        rect[3] = pts[np.argmax(d)]


        actualboard = np.float32([[0,0], [400, 0], [400, 300], [0, 300]])
        persp_M = cv2.getPerspectiveTransform(rect, actualboard)
        persp_img = cv2.warpPerspective(img, persp_M, (400,300))

        cv2.drawContours(img, [edge], -1, (0, 0, 255), 3)

    # --- masking ---
    if persp_img != None:
        hsv = cv2.cvtColor(persp_img, cv2.COLOR_BGR2HSV)
        for obj, (lower, upper) in objects.items():
            upper = np.array(upper)
            lower = np.array(lower)
            mask = cv2.inRange(hsv, lower, upper)
            # persp_img = cv2.bitwise_and(persp_img,persp_img,mask = mask)
            (contours, cnts, _) = cv2.findContours(mask.copy(),
                                                cv2.RETR_EXTERNAL,
                                                cv2.CHAIN_APPROX_SIMPLE)

            masked = cv2.bitwise_and(persp_img, persp_img, mask=mask)

            areas = cnts
            areas = [x for x in areas if cv2.contourArea(x) > 20]
            areas = sorted(areas, key=cv2.contourArea, reverse=True)[:3]
            for c in areas:
                peri = cv2.arcLength(c, True)
                approx = cv2.approxPolyDP(c, 0.05 * peri, True)
                (x,y), radius = cv2.minEnclosingCircle(c)
                print obj + " : " + "x: " + str(200-x) + "y: " + str(y+50) + " rad: " + str(radius)
                cv2.drawContours(masked, [approx], -1, (0, 255, 0), 4)
            cv2.imshow('persp', persp_img)
            cv2.imshow('masked_' + obj, masked)
    cv2.imshow('original', img)
    k = cv2.waitKey(5) & 0xFF
    # if k == 27:
    #     break

cap.release()
cv2.destroyAllWindows()
