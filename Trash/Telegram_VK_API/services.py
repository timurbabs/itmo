import vk_api
import io


class Vk:
    vk_session = None
    api = None
    api_token = "32bf34eaa9def12afd4b588a8035915c460b5ec7a7bf31c2743aebd652259915cecc1afa5970c419ed595"

    @classmethod
    def __two_factor(cls):
        code = input('Code? ')
        return code

    @classmethod
    def auth(cls):
        cls.vk_session = vk_api.VkApi(token=cls.api_token)
        cls.api = cls.vk_session.get_api()

    @classmethod
    def get_group_name(cls, group_id):
        result = cls.api.groups.getById(group_id=group_id)
        return result[0]["name"]

    @classmethod
    def post(cls, group_id, text):
        cls.api.wall.post(owner_id=-group_id, from_group=1, message=text)

    @classmethod
    def post_photo(cls, group_id, photo, message):
        file = io.BytesIO(photo)
        photo = vk_api.VkUpload(cls.api).photo_wall(photos=[file], group_id=group_id)[-1]
        attachment = f"photo{photo['owner_id']}_{photo['id']}"
        if message:
            cls.api.wall.post(owner_id=-group_id, message=message, attachments=attachment)
        else:
            cls.api.wall.post(owner_id=-group_id, attachments=attachment)

    @classmethod
    def post_video(cls, group_id, video, message, name):
        file = io.BytesIO(video)
        video = vk_api.VkUpload(cls.api).video(video_file=[file], group_id=group_id, wallpost=True, name="TestVID")
        attachment = f"video{video['owner_id']}_{video['video_id']}"
        if message:
            cls.api.wall.post(owner_id=-group_id, message=message, attachments=attachment)
        else:
            cls.api.wall.post(owner_id=-group_id, attachments=attachment)

    @classmethod
    def post_document(cls, group_id, document, message, name):
        file = io.BytesIO(document)
        document = vk_api.VkUpload(cls.api).document_wall(doc=[file], group_id=group_id, title=name)
        print(document)
        attachment = f"doc{document['owner_id']}_{document['doc_id']}"
        if message:
            cls.api.wall.post(owner_id=-group_id, message=message, attachments=attachment)
        else:
            cls.api.wall.post(owner_id=-group_id, attachments=attachment)
