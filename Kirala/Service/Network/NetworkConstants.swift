//
//  Constants.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

enum NetworkConstants {
    static var baseUrl: String {
    #if DEBUG
        //return "http://localhost:8080"
        //return "http://192.168.1.26:8080"
        return "https://kirala-dev.onrender.com"
        //return   "http://13.61.3.36:8080"
        //return "http://172.16.34.221:8080"
        //return "http://192.168.1.111:8080"
        //return "http://172.16.35.37:8080"
        //return "http://192.168.214.230:8080"
    #else
        return "https://example.com/api"
    #endif
    }
    
    enum Endpoints {
        enum Auth {
            static let loginWithGoogle = "oauth2/authorize/google"
            static let login = "/auth/login"
            static let register = "/auth/register"
            static let logout = "/auth/logout"
            static let forgotPassword = "/auth/send-reset-password-token"
            static let resetPassword = "/auth/reset-password"
            static let resendVerificationEmail = "/auth/send-email-verification-token"
        }
        
        enum Category {
            static let getCategories = "/categories"
            static let getSubcategories = "/subcategories/category/"
            static let getBrands = "/brands"
            static let getCities = "/cities"
            static let getCampaigns = "/campaigns"
            static let getCategoryListWithSubcategories = "/categories/subcategories"
        }
        
        enum Product {
            static let createProduct = "/products"
            static let getProductsByUser = "/products/user"
            static let getProductById = "/products/"
            static let updateProduct = "/products"
            static let deleteProduct = "/products/"
            static let getProducts = "/products"
            static let getSearchedProducts = "/products/search"
            static let getProductDetail = "/products/details"
            static let rentProduct = "/orders"
        }
        
        enum Favorite {
            static let getFavorites = "/favorites"
            static let toggleFavorite = "/favorites"
        }
        
    }
    
    enum Constraints {
        static let paginationSize = 10
        static let infinityScrollLateLimitSecond = 1.0
        static let infinityScrollPercentage = 0.9
    }
    
    
    static let mockImageUrls: [URL] = [
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1570/prod/QC/20240925/15/8d480e57-dd9f-33be-869d-d6a99e2adade/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240925/15/f0b8c711-ff2f-3710-acf9-5cd771967845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/11/e93aaa49-1c9e-34bd-a82e-abf40880b39e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1315/product/media/images/prod/QC/20240516/11/0e13fb17-e88c-30b3-adee-ba925ee8c782/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty733/product/media/images/20230215/16/281514998/111694438/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty732/product/media/images/20230215/16/281514998/111694438/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1024/product/media/images/prod/PIM/20231025/06/0fd69241-dbf3-4b43-a692-899775a80ef6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty540/product/media/images/20220926/18/180084094/538071101/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1447/product/media/images/prod/QC/20240729/09/e17bdc05-7683-3e80-b81f-e87fc8a6b876/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/7b24976e-e76d-3194-9da6-017f47909a14/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty535/product/media/images/20220920/12/177395184/573896464/6/6_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty536/product/media/images/20220920/12/177395184/573896464/7/7_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240916/09/c684fa8d-8545-3cb5-aa15-ba8eb8c255cc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/prod/QC/20240916/09/cfa89e65-f54e-3871-87ad-8175196033e7/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/3ff94a9e-df9a-3175-90b7-c3dc1cb78e73/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/258683e4-28c1-3826-9670-46188df621c0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1585/prod/QC/20241014/13/f6c01efa-d6f5-3806-a7b7-c5638551bc4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/f4baf3f8-9ab3-3798-90c7-d6c9d9504237/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240926/10/6624c92d-ffd6-33ae-830f-01007f1a2325/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240926/10/441ca172-2ae9-38b6-9f92-47a70df95766/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1513/product/media/images/prod/QC/20240830/01/0cc96eca-259a-347a-8f71-28ba9c563f6a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1603/prod/QC/20241121/10/56a84499-32b3-374a-865d-0c79a8c7e020/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty277/product/media/images/20211221/16/14559465/342205646/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty276/product/media/images/20211221/16/14559465/342205646/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/2b70e5e3-c0bb-39ae-924a-bd41569041de/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/44f32513-8cf8-3ba7-9dcd-48d39915cc7b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241029/16/81b34bdc-5353-3f44-8f22-58817aad33dc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/b68ecfb8-1df8-305f-a1eb-8219cd36986c/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/134152bb-b725-3fe0-acb9-54ee599b3c13/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1257/product/media/images/prod/SPM/PIM/20240415/11/847e381c-2fe2-3645-aa25-dacc54ec4d37/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240515/14/b2460abb-4d95-3960-bd36-df0fcbec4121/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty813/product/media/images/20230405/12/318761422/22005446/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240917/02/8b394267-1b35-3e46-8ca2-1bb802686975/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/9643298e-65e1-32dc-b252-a730c3aaa198/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1553/prod/QC/20240917/13/16920366-48df-3d84-8a74-628a76643845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1416/product/media/images/prod/QC/20240712/12/da2a8b02-962a-3a46-9764-ef99dfaa7349/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1417/product/media/images/prod/QC/20240712/12/98ed2619-0671-31aa-b4f9-5a5f53a4c89a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1029/product/media/images/prod/SPM/PIM/20231102/16/2545f337-d7c0-309c-8d70-11fad0b3d1c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1031/product/media/images/prod/SPM/PIM/20231102/16/84ac8bc8-59f3-3a2b-97f6-109a13a71145/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1006/product/media/images/prod/SPM/PIM/20230929/15/13eecdaa-ed18-3610-90b6-726f3c7d27a0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty987/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053589/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty989/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053593/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1342/product/media/images/prod/QC/20240531/04/70d72990-dc6c-3da9-90ec-0c02ce8e7552/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1341/product/media/images/prod/QC/20240531/04/226e1f09-bdc0-3059-885f-c8d8e6734202/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty150/product/media/images/20210729/16/113766387/10134133/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty152/product/media/images/20210729/16/113766387/10134133/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/product/media/images/ty1548/prod/QC/20240916/20/20766a5b-f625-36ce-86cf-65e48d966a93/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/20/e7f77216-257f-3b9a-8946-31a84035aa3e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240925/04/0e95be23-9ea5-3f78-9f6c-a4ba368209b6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty510/product/media/images/20220819/12/162769283/535963447/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty512/product/media/images/20220819/12/162769283/535963447/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1082/product/media/images/prod/SPM/PIM/20231207/11/01d1b716-06aa-304a-960b-b104c4837ec5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1496/product/media/images/prod/QC/20240822/12/c935c07b-5745-3fd1-ba1c-9608d7219ff1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1390/product/media/images/prod/QC/20240629/14/a4926d7d-a05b-3238-870b-459e6693f5b9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1172/product/media/images/prod/SPM/PIM/20240215/11/cb4f2827-8e37-3c8e-ae04-cdfea923c3f0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1017/product/media/images/prod/SPM/PIM/20231018/21/6d32725b-9b40-3e36-876c-6694d3817ee5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/14/52b0a590-20b5-32da-bb17-8c151fae6e63/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240924/12/faff19b1-a229-3936-8370-f565e257fd66/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/01/e162159b-844a-3def-a864-6d68a98fef69/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1219/product/media/images/prod/SPM/PIM/20240321/15/c6f8a41f-8c22-38c1-aa5c-ffa7cf7f4de3/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1084/product/media/images/prod/SPM/PIM/20231209/05/f15a067f-f8d3-3209-9ec8-8078eaaf5d49/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1548/prod/QC/20240916/09/4afd2df2-c42e-3fd5-a34e-de5f1eff2b1e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty966/product/media/images/20230715/19/394144502/10741120/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1542/prod/QC/20240913/19/4f5e45b4-6437-304f-9b6f-05303aa66ecb/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1552/prod/QC/20240917/13/3a4b4274-a4ce-3301-8826-0991136632c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/60a64c78-366a-3900-9a74-df0f5ff11a7a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1552/product/media/images/ty1553/prod/QC/20240917/13/a641c839-cf9a-3f85-bb71-e048d3336b4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1553/product/media/images/ty1551/prod/QC/20240917/13/9598b0ba-cb8b-31bb-bf42-cd98413dac88/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241025/16/86a26f8c-f8c9-3238-8295-79c1d95a7244/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty955/product/media/images/20230622/16/388194671/232491004/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty972/product/media/images/20230729/3/397884604/983629085/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1589/prod/QC/20241018/16/288f4814-ec7f-3302-9b5e-45b3e9279369/1_org_zoom.jpg".imageUrl,
        
        
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1570/prod/QC/20240925/15/8d480e57-dd9f-33be-869d-d6a99e2adade/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240925/15/f0b8c711-ff2f-3710-acf9-5cd771967845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/11/e93aaa49-1c9e-34bd-a82e-abf40880b39e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1315/product/media/images/prod/QC/20240516/11/0e13fb17-e88c-30b3-adee-ba925ee8c782/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty733/product/media/images/20230215/16/281514998/111694438/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty732/product/media/images/20230215/16/281514998/111694438/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1024/product/media/images/prod/PIM/20231025/06/0fd69241-dbf3-4b43-a692-899775a80ef6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty540/product/media/images/20220926/18/180084094/538071101/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1447/product/media/images/prod/QC/20240729/09/e17bdc05-7683-3e80-b81f-e87fc8a6b876/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/7b24976e-e76d-3194-9da6-017f47909a14/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty535/product/media/images/20220920/12/177395184/573896464/6/6_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty536/product/media/images/20220920/12/177395184/573896464/7/7_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240916/09/c684fa8d-8545-3cb5-aa15-ba8eb8c255cc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/prod/QC/20240916/09/cfa89e65-f54e-3871-87ad-8175196033e7/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/3ff94a9e-df9a-3175-90b7-c3dc1cb78e73/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty994/product/media/images/prod/SPM/PIM/20230906/18/258683e4-28c1-3826-9670-46188df621c0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1585/prod/QC/20241014/13/f6c01efa-d6f5-3806-a7b7-c5638551bc4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1448/product/media/images/prod/QC/20240729/09/f4baf3f8-9ab3-3798-90c7-d6c9d9504237/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1571/prod/QC/20240926/10/6624c92d-ffd6-33ae-830f-01007f1a2325/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240926/10/441ca172-2ae9-38b6-9f92-47a70df95766/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1513/product/media/images/prod/QC/20240830/01/0cc96eca-259a-347a-8f71-28ba9c563f6a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1603/prod/QC/20241121/10/56a84499-32b3-374a-865d-0c79a8c7e020/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty277/product/media/images/20211221/16/14559465/342205646/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty276/product/media/images/20211221/16/14559465/342205646/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/2b70e5e3-c0bb-39ae-924a-bd41569041de/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1594/prod/QC/20241029/16/44f32513-8cf8-3ba7-9dcd-48d39915cc7b/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241029/16/81b34bdc-5353-3f44-8f22-58817aad33dc/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/b68ecfb8-1df8-305f-a1eb-8219cd36986c/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1584/prod/QC/20241017/15/134152bb-b725-3fe0-acb9-54ee599b3c13/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty967/product/media/images/20230718/16/394783541/979659179/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1257/product/media/images/prod/SPM/PIM/20240415/11/847e381c-2fe2-3645-aa25-dacc54ec4d37/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty434/product/media/images/20220518/21/113347017/482257420/3/3_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240515/14/b2460abb-4d95-3960-bd36-df0fcbec4121/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty813/product/media/images/20230405/12/318761422/22005446/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/prod/QC/20240917/02/8b394267-1b35-3e46-8ca2-1bb802686975/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/9643298e-65e1-32dc-b252-a730c3aaa198/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1553/prod/QC/20240917/13/16920366-48df-3d84-8a74-628a76643845/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1416/product/media/images/prod/QC/20240712/12/da2a8b02-962a-3a46-9764-ef99dfaa7349/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1417/product/media/images/prod/QC/20240712/12/98ed2619-0671-31aa-b4f9-5a5f53a4c89a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1029/product/media/images/prod/SPM/PIM/20231102/16/2545f337-d7c0-309c-8d70-11fad0b3d1c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1031/product/media/images/prod/SPM/PIM/20231102/16/84ac8bc8-59f3-3a2b-97f6-109a13a71145/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1006/product/media/images/prod/SPM/PIM/20230929/15/13eecdaa-ed18-3610-90b6-726f3c7d27a0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty987/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053589/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty989/product/media/images/jpim-outputs/assets/product/media/images/20230824/17/407053593/425004585/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1342/product/media/images/prod/QC/20240531/04/70d72990-dc6c-3da9-90ec-0c02ce8e7552/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1341/product/media/images/prod/QC/20240531/04/226e1f09-bdc0-3059-885f-c8d8e6734202/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty150/product/media/images/20210729/16/113766387/10134133/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty152/product/media/images/20210729/16/113766387/10134133/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1548/product/media/images/ty1548/prod/QC/20240916/20/20766a5b-f625-36ce-86cf-65e48d966a93/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/20/e7f77216-257f-3b9a-8946-31a84035aa3e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240925/04/0e95be23-9ea5-3f78-9f6c-a4ba368209b6/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty510/product/media/images/20220819/12/162769283/535963447/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty512/product/media/images/20220819/12/162769283/535963447/2/2_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1082/product/media/images/prod/SPM/PIM/20231207/11/01d1b716-06aa-304a-960b-b104c4837ec5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1496/product/media/images/prod/QC/20240822/12/c935c07b-5745-3fd1-ba1c-9608d7219ff1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1390/product/media/images/prod/QC/20240629/14/a4926d7d-a05b-3238-870b-459e6693f5b9/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1172/product/media/images/prod/SPM/PIM/20240215/11/cb4f2827-8e37-3c8e-ae04-cdfea923c3f0/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1017/product/media/images/prod/SPM/PIM/20231018/21/6d32725b-9b40-3e36-876c-6694d3817ee5/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1550/prod/QC/20240916/14/52b0a590-20b5-32da-bb17-8c151fae6e63/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1569/prod/QC/20240924/12/faff19b1-a229-3936-8370-f565e257fd66/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1579/prod/QC/20241007/01/e162159b-844a-3def-a864-6d68a98fef69/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1219/product/media/images/prod/SPM/PIM/20240321/15/c6f8a41f-8c22-38c1-aa5c-ffa7cf7f4de3/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1084/product/media/images/prod/SPM/PIM/20231209/05/f15a067f-f8d3-3209-9ec8-8078eaaf5d49/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1549/product/media/images/ty1548/prod/QC/20240916/09/4afd2df2-c42e-3fd5-a34e-de5f1eff2b1e/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty966/product/media/images/20230715/19/394144502/10741120/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1542/prod/QC/20240913/19/4f5e45b4-6437-304f-9b6f-05303aa66ecb/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1552/prod/QC/20240917/13/3a4b4274-a4ce-3301-8826-0991136632c8/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1551/product/media/images/ty1551/prod/QC/20240917/13/60a64c78-366a-3900-9a74-df0f5ff11a7a/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1552/product/media/images/ty1553/prod/QC/20240917/13/a641c839-cf9a-3f85-bb71-e048d3336b4f/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1553/product/media/images/ty1551/prod/QC/20240917/13/9598b0ba-cb8b-31bb-bf42-cd98413dac88/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1595/prod/QC/20241025/16/86a26f8c-f8c9-3238-8295-79c1d95a7244/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty955/product/media/images/20230622/16/388194671/232491004/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty972/product/media/images/20230729/3/397884604/983629085/1/1_org_zoom.jpg".imageUrl,
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1589/prod/QC/20241018/16/288f4814-ec7f-3302-9b5e-45b3e9279369/1_org_zoom.jpg".imageUrl,
    ]
    
    
    static let mockCampaignUrls: [URL] = [
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/7946f9ea-8cff-43e6-bb9c-8c35afdcedebtr_3206619.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1606/tr-event-banner/088c34ee-a153-423d-a07c-650f7e9847e6tr_3207482.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/1d0af2bd-dbf2-4f90-9bf6-a8c4465ac71btr_3205959.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/a1d225b2-1024-4abd-9ddb-8326b6dfb35dtr_3206496.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/5b206aa5-5bd7-420a-80f0-4a2a83c67f93tr_3206705.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/03c69356-06f7-46f0-a3a2-141d7c26637btr_3207171.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/f41a8017-de56-4aea-9d3d-f38576fe3aeetr_3207025.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1605/tr-event-banner/42d55bd6-9185-40f2-948c-6adb83b6ef8ctr_3207133.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/cdfd180b-cca6-4c33-a800-e187b0c6aaa0tr_3205296.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1606/tr-event-banner/3a1c9a3e-5ef8-4f4c-a263-22db0c50429ctr_3204795.jpeg".imageUrl,
        
        "https://up.roketfy.com/media/trendyol-kampanya-nasil-yapilir.webp".imageUrl,
        "https://up.roketfy.com/media/trendyol-kampanya-nasil-yapilir.webp".imageUrl,
        "https://up.roketfy.com/media/trendyol-kampanya-nasil-yapilir.webp".imageUrl,
        
        "https://www.ininal.com/uploads/2022/09/23/web1920x1080ininal-x-trendyol-kampanyasi_1663936311.png".imageUrl,
        "https://pazarlamaturkiye.com/wp-content/uploads/2020/09/1600335251_Trendyol_Reklam_Kampanyas__3-800x464.jpeg".imageUrl,
        "https://media.licdn.com/dms/image/v2/D4D12AQEFGDXMsNjTDQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1668172426828?e=1738195200&v=beta&t=QFQp0BBT30jqqh0_eHKyV7ASlTdn36rBIPT-QVLOqyg".imageUrl,
        "https://media.licdn.com/dms/image/v2/D4D12AQFxSGp9bdy42Q/article-inline_image-shrink_1500_2232/article-inline_image-shrink_1500_2232/0/1668172490515?e=1738195200&v=beta&t=BcHeu_KKYCfR_Yk_qYq0IFgeqZhSNBMMC_wpdKUqdpU".imageUrl,
        "https://media.licdn.com/dms/image/v2/D4D12AQGIOm6jk_Pr8Q/article-inline_image-shrink_1500_2232/article-inline_image-shrink_1500_2232/0/1668173138377?e=1738195200&v=beta&t=G9x2TWqTiaWq_gzOiCjqSLG-RiqGDtxevjsgRTDdf44".imageUrl,
        "https://static.daktilo.com/sites/1168/uploads/2024/09/26/trendyolda-kampanya-cilginligi-basladi.webp".imageUrl,
        "https://www.worldcard.com.tr/getmedia/ecfdbc86-c1e9-4c7a-ab84-6053d76860cd/30008200005_1.webp?ext=.webp".imageUrl,
        "https://www.hedefhalk.com/images/haberler/2021/04/trendyol-bahari-kampanya-ile-karsiliyor-1619508640.jpg".imageUrl,
        "https://image.hurimg.com/i/hurriyet/75/0x0/61aa15d74e3fe0042c173b0e.jpg".imageUrl,
        "https://www.paraf.com.tr/tr/kampanyalar/e-ticaret/trendyolda-pesin-fiyatina-3-taksit-firsati123/_jcr_content/root/responsivegrid/container_109478952_/teaser.coreimg.100.3840.jpeg/1675932603460/trendyol-paraf-kampanyadetaybanner-guide-text.jpeg".imageUrl,
        "https://cdn.dsmcdn.com/ty1607/tr-event-banner/11b97465-1004-4326-b442-f2969c171093tr_3206781.jpeg".imageUrl,
    ]
    
}
